$.fn.extend
  file_uploader: ->
    if this.length
      new FileUploader this

class FileUploader
  constructor: (form) ->
    @form = form
    @form[0].uploader = @
    @form.on 'submit', @_form_submit

    @submit_button = @form.find('input[type=submit], button[type=submit]')

    @file_input = @form.find('input[type=file]')
    @file_input.on 'change', @_file_changed
    @change_file(@file_input[0].files[0]) unless @file_input.val() == ''

    @progress_bar = $('#progress')

    @_chunk_size = parseInt(1024 * 100)
    @_request = new XMLHttpRequest
    @_request.uploader = @
    @_request.onload = @_chunk_complete

  start: ->
    if @file
      @on_begin()
      @_range_start = 0
      @_range_end = @_chunk_size
      @_url = @form.attr('action') + "?name=#{@file.name}&type=#{@file.type}&upload_id=#{@_generate_upload_id()}"
      @_csrf_token = $('meta[name=csrf-token]').attr('content')
      @_upload()
    else
      alert('Файл не выбран!')
      return

  change_file: (file)->
    @file = file
    @_slice_method = @_detect_slice_method() if @file && !@_slice_method

  _upload: ->
    self = @
    chunk = null
    @on_progress()

    @_range_end = @file.size if @_range_end > @file.size

    chunk = @file[@_slice_method](@_range_start, @_range_end)

    @_request.open('POST', @_url, true)
    @_request.setRequestHeader('Content-Type', 'application/octet-stream')
    @_request.overrideMimeType('application/octet-stream')
    @_request.setRequestHeader( 'X-CSRF-Token', @_csrf_token )

    if @file.size > @_chunk_size
      @_request.setRequestHeader(
        'Content-Range',
        'bytes ' + @_range_start + '-' + @_range_end + '/' + @file.size
      )

    @_request.send(chunk)

  # Uploader events
  on_begin: ->
    @on_progress()
    @submit_button.attr('disabled', true)
    @progress_bar.slideToggle()

  on_progress: ->
    percentage = @_get_upload_percentage()
    bar = @progress_bar.children().first()
    bar.attr('aria-valuenow', percentage)
    bar.css('width', percentage.toString() + '%')
    bar.text(percentage.toString() + '%')

  on_end: ->
    @on_progress()
    self = @

    if @success == true
      @form.slideUp()
      setTimeout( ->
        document.location = Routes.file_upload_path(self.file_upload_id)
        self.form.slideDown()
        self.form.html('<h3>Файл успешншно загружен. Перенаправление на страницу файла...</h3>')
      , 500)
    else
      setTimeout( ->
        alert('Ошибка загрузки файла!')
        self.submit_button.removeAttr('disabled')
        self.progress_bar.slideToggle()
      , 500)

  _get_upload_percentage: ->
    if @_range_end == @_chunk_size
      0
    else
      parseInt((@_range_end / @file.size) * 100)

  # Request Events
  _chunk_complete: (e) ->
    if e.target.status == 201
      @uploader.file_upload_id = e.target.responseText
      @uploader._upload_complete()
      return
    else if e.target.status != 200 && e.target.status != 206
      @uploader._upload_failed()
      return

    @uploader._range_start = @uploader._range_end
    @uploader._range_end = @uploader._range_start + @uploader._chunk_size
    @uploader._upload() #if !@uploader.is_paused

  _upload_complete: ->
    @success = true
    @on_end()

  _upload_failed: ->
    @success = false
    @on_end()

  # Form Events
  _file_changed: (e) ->
    $(e.target).closest('form')[0].uploader.change_file(e.target.files[0])

  _form_submit: (e) ->
    e.preventDefault()
    @uploader.start()
    false

  # Generate unique upload id
  _generate_upload_id: ->
    uid = ->
      (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1)
    upload_id = ''
    for [1..8]
      upload_id += uid()
    upload_id

  # Detect slice method
  _detect_slice_method: ->
    if 'mozSlice' in @file
      'mozSlice'
    else if 'webkitSlice' in @file
      'webkitSlice'
    else
      'slice'