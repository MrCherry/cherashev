class FileUploader
  attr_reader :original_file_name, :file_type, :upload_id, :file_upload

  def initialize(file_name:, file_type:, upload_id:, chunk:, content_range_header:)
    @original_file_name = file_name
    @file_type = file_type
    @upload_id = upload_id
    @chunk = chunk
    set_content_range(content_range_header)
  end

  def upload!
    apply_chunk @chunk

    if last_chunk_received?
      if create_file_upload_record!
        move_from_tmp_to_public
      else
        remove_file(tmp_file_path)
      end
    end
  end

  def self.remove_file(file_path)
    FileUtils::rm file_path
  end

  private

    def move_from_tmp_to_public
      FileUtils::mv tmp_file_path, uploaded_file_path
    end

    def last_chunk_received?
      @range_end >= @file_size
    end

    def create_file_upload_record!
      @file_upload = FileUpload.new(
          original_file_name: @original_file_name,
          file_name: file_name,
          file_type: @file_type
      )

      @file_upload.save!
    end

    def set_content_range(content_range_header)
      if content_range_header.present?
        regex = /([0-9]+)\-([0-9]+)\/([0-9]+)/ix
        matches = regex.match(content_range_header).to_a
        matches.shift
        @range_start, @range_end, @file_size = matches.map(&:to_i)
      else
        @range_start = 0
        @range_end = @file_size = @chunk.size
      end
    end

    def apply_chunk(chunk)
      file = File.open(tmp_file_path, file_mode)
      file.write chunk
    ensure
      file.close unless file.blank?
    end

    def file_name
      Digest::MD5.hexdigest(@original_file_name + @upload_id)
    end

    def tmp_path
      path = Rails.root.join('tmp','uploads')
      FileUtils::mkdir_p path.to_s unless path.exist?
      path
    end

    def tmp_file_path
      tmp_path.join(file_name)
    end

    def uploads_path
      path = Rails.configuration.uploads_path
      FileUtils::mkdir_p path.to_s unless path.exist?
      path
    end

    def uploaded_file_path
      uploads_path.join(file_name)
    end

    def file_mode
      if @range_start == 0
        'w+b'
      else
        'a+b'
      end
    end

end
