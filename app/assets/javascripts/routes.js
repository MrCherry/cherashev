(function() {
  var NodeTypes, ParameterMissing, Utils, createGlobalJsRoutesObject, defaults, root,
    __hasProp = {}.hasOwnProperty;

  root = typeof exports !== "undefined" && exports !== null ? exports : this;

  ParameterMissing = function(message) {
    this.message = message;
  };

  ParameterMissing.prototype = new Error();

  defaults = {
    prefix: "",
    default_url_options: {}
  };

  NodeTypes = {"GROUP":1,"CAT":2,"SYMBOL":3,"OR":4,"STAR":5,"LITERAL":6,"SLASH":7,"DOT":8};

  Utils = {
    serialize: function(object, prefix) {
      var element, i, key, prop, result, s, _i, _len;

      if (prefix == null) {
        prefix = null;
      }
      if (!object) {
        return "";
      }
      if (!prefix && !(this.get_object_type(object) === "object")) {
        throw new Error("Url parameters should be a javascript hash");
      }
      if (root.jQuery) {
        result = root.jQuery.param(object);
        return (!result ? "" : result);
      }
      s = [];
      switch (this.get_object_type(object)) {
        case "array":
          for (i = _i = 0, _len = object.length; _i < _len; i = ++_i) {
            element = object[i];
            s.push(this.serialize(element, prefix + "[]"));
          }
          break;
        case "object":
          for (key in object) {
            if (!__hasProp.call(object, key)) continue;
            prop = object[key];
            if (!(prop != null)) {
              continue;
            }
            if (prefix != null) {
              key = "" + prefix + "[" + key + "]";
            }
            s.push(this.serialize(prop, key));
          }
          break;
        default:
          if (object) {
            s.push("" + (encodeURIComponent(prefix.toString())) + "=" + (encodeURIComponent(object.toString())));
          }
      }
      if (!s.length) {
        return "";
      }
      return s.join("&");
    },
    clean_path: function(path) {
      var last_index;

      path = path.split("://");
      last_index = path.length - 1;
      path[last_index] = path[last_index].replace(/\/+/g, "/");
      return path.join("://");
    },
    set_default_url_options: function(optional_parts, options) {
      var i, part, _i, _len, _results;

      _results = [];
      for (i = _i = 0, _len = optional_parts.length; _i < _len; i = ++_i) {
        part = optional_parts[i];
        if (!options.hasOwnProperty(part) && defaults.default_url_options.hasOwnProperty(part)) {
          _results.push(options[part] = defaults.default_url_options[part]);
        }
      }
      return _results;
    },
    extract_anchor: function(options) {
      var anchor;

      anchor = "";
      if (options.hasOwnProperty("anchor")) {
        anchor = "#" + options.anchor;
        delete options.anchor;
      }
      return anchor;
    },
    extract_trailing_slash: function(options) {
      var trailing_slash;

      trailing_slash = false;
      if (defaults.default_url_options.hasOwnProperty("trailing_slash")) {
        trailing_slash = defaults.default_url_options.trailing_slash;
      }
      if (options.hasOwnProperty("trailing_slash")) {
        trailing_slash = options.trailing_slash;
        delete options.trailing_slash;
      }
      return trailing_slash;
    },
    extract_options: function(number_of_params, args) {
      var last_el;

      last_el = args[args.length - 1];
      if (args.length > number_of_params || ((last_el != null) && "object" === this.get_object_type(last_el) && !this.look_like_serialized_model(last_el))) {
        return args.pop();
      } else {
        return {};
      }
    },
    look_like_serialized_model: function(object) {
      return "id" in object || "to_param" in object;
    },
    path_identifier: function(object) {
      var property;

      if (object === 0) {
        return "0";
      }
      if (!object) {
        return "";
      }
      property = object;
      if (this.get_object_type(object) === "object") {
        if ("to_param" in object) {
          property = object.to_param;
        } else if ("id" in object) {
          property = object.id;
        } else {
          property = object;
        }
        if (this.get_object_type(property) === "function") {
          property = property.call(object);
        }
      }
      return property.toString();
    },
    clone: function(obj) {
      var attr, copy, key;

      if ((obj == null) || "object" !== this.get_object_type(obj)) {
        return obj;
      }
      copy = obj.constructor();
      for (key in obj) {
        if (!__hasProp.call(obj, key)) continue;
        attr = obj[key];
        copy[key] = attr;
      }
      return copy;
    },
    prepare_parameters: function(required_parameters, actual_parameters, options) {
      var i, result, val, _i, _len;

      result = this.clone(options) || {};
      for (i = _i = 0, _len = required_parameters.length; _i < _len; i = ++_i) {
        val = required_parameters[i];
        if (i < actual_parameters.length) {
          result[val] = actual_parameters[i];
        }
      }
      return result;
    },
    build_path: function(required_parameters, optional_parts, route, args) {
      var anchor, opts, parameters, result, trailing_slash, url, url_params;

      args = Array.prototype.slice.call(args);
      opts = this.extract_options(required_parameters.length, args);
      if (args.length > required_parameters.length) {
        throw new Error("Too many parameters provided for path");
      }
      parameters = this.prepare_parameters(required_parameters, args, opts);
      this.set_default_url_options(optional_parts, parameters);
      anchor = this.extract_anchor(parameters);
      trailing_slash = this.extract_trailing_slash(parameters);
      result = "" + (this.get_prefix()) + (this.visit(route, parameters));
      url = Utils.clean_path("" + result);
      if (trailing_slash === true) {
        url = url.replace(/(.*?)[\/]?$/, "$1/");
      }
      if ((url_params = this.serialize(parameters)).length) {
        url += "?" + url_params;
      }
      url += anchor;
      return url;
    },
    visit: function(route, parameters, optional) {
      var left, left_part, right, right_part, type, value;

      if (optional == null) {
        optional = false;
      }
      type = route[0], left = route[1], right = route[2];
      switch (type) {
        case NodeTypes.GROUP:
          return this.visit(left, parameters, true);
        case NodeTypes.STAR:
          return this.visit_globbing(left, parameters, true);
        case NodeTypes.LITERAL:
        case NodeTypes.SLASH:
        case NodeTypes.DOT:
          return left;
        case NodeTypes.CAT:
          left_part = this.visit(left, parameters, optional);
          right_part = this.visit(right, parameters, optional);
          if (optional && !(left_part && right_part)) {
            return "";
          }
          return "" + left_part + right_part;
        case NodeTypes.SYMBOL:
          value = parameters[left];
          if (value != null) {
            delete parameters[left];
            return this.path_identifier(value);
          }
          if (optional) {
            return "";
          } else {
            throw new ParameterMissing("Route parameter missing: " + left);
          }
          break;
        default:
          throw new Error("Unknown Rails node type");
      }
    },
    build_path_spec: function(route, wildcard) {
      var left, right, type;

      if (wildcard == null) {
        wildcard = false;
      }
      type = route[0], left = route[1], right = route[2];
      switch (type) {
        case NodeTypes.GROUP:
          return "(" + (this.build_path_spec(left)) + ")";
        case NodeTypes.CAT:
          return "" + (this.build_path_spec(left)) + (this.build_path_spec(right));
        case NodeTypes.STAR:
          return this.build_path_spec(left, true);
        case NodeTypes.SYMBOL:
          if (wildcard === true) {
            return "" + (left[0] === '*' ? '' : '*') + left;
          } else {
            return ":" + left;
          }
          break;
        case NodeTypes.SLASH:
        case NodeTypes.DOT:
        case NodeTypes.LITERAL:
          return left;
        default:
          throw new Error("Unknown Rails node type");
      }
    },
    visit_globbing: function(route, parameters, optional) {
      var left, right, type, value;

      type = route[0], left = route[1], right = route[2];
      if (left.replace(/^\*/i, "") !== left) {
        route[1] = left = left.replace(/^\*/i, "");
      }
      value = parameters[left];
      if (value == null) {
        return this.visit(route, parameters, optional);
      }
      parameters[left] = (function() {
        switch (this.get_object_type(value)) {
          case "array":
            return value.join("/");
          default:
            return value;
        }
      }).call(this);
      return this.visit(route, parameters, optional);
    },
    get_prefix: function() {
      var prefix;

      prefix = defaults.prefix;
      if (prefix !== "") {
        prefix = (prefix.match("/$") ? prefix : "" + prefix + "/");
      }
      return prefix;
    },
    route: function(required_parts, optional_parts, route_spec) {
      var path_fn;

      path_fn = function() {
        return Utils.build_path(required_parts, optional_parts, route_spec, arguments);
      };
      path_fn.required_params = required_parts;
      path_fn.toString = function() {
        return Utils.build_path_spec(route_spec);
      };
      return path_fn;
    },
    _classToTypeCache: null,
    _classToType: function() {
      var name, _i, _len, _ref;

      if (this._classToTypeCache != null) {
        return this._classToTypeCache;
      }
      this._classToTypeCache = {};
      _ref = "Boolean Number String Function Array Date RegExp Object Error".split(" ");
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        name = _ref[_i];
        this._classToTypeCache["[object " + name + "]"] = name.toLowerCase();
      }
      return this._classToTypeCache;
    },
    get_object_type: function(obj) {
      if (root.jQuery && (root.jQuery.type != null)) {
        return root.jQuery.type(obj);
      }
      if (obj == null) {
        return "" + obj;
      }
      if (typeof obj === "object" || typeof obj === "function") {
        return this._classToType()[Object.prototype.toString.call(obj)] || "object";
      } else {
        return typeof obj;
      }
    }
  };

  createGlobalJsRoutesObject = function() {
    var namespace;

    namespace = function(mainRoot, namespaceString) {
      var current, parts;

      parts = (namespaceString ? namespaceString.split(".") : []);
      if (!parts.length) {
        return;
      }
      current = parts.shift();
      mainRoot[current] = mainRoot[current] || {};
      return namespace(mainRoot[current], parts.join("."));
    };
    namespace(root, "Routes");
    root.Routes = {
// blog => /blog(.:format)
  // function(options)
  blog_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"blog",false],[1,[2,[8,".",false],[3,"format",false]],false]]], arguments),
// blog_post => /blog/:id(.:format)
  // function(id, options)
  blog_post_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"blog",false],[2,[7,"/",false],[2,[3,"id",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// cancel_user_registration => /users/cancel(.:format)
  // function(options)
  cancel_user_registration_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"users",false],[2,[7,"/",false],[2,[6,"cancel",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// destroy_user_session => /users/sign_out(.:format)
  // function(options)
  destroy_user_session_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"users",false],[2,[7,"/",false],[2,[6,"sign_out",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// download_file_upload => /download/:file_name(.:format)
  // function(file_name, options)
  download_file_upload_path: Utils.route(["file_name"], ["format"], [2,[7,"/",false],[2,[6,"download",false],[2,[7,"/",false],[2,[3,"file_name",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// edit_file_upload => /file_uploads/:id/edit(.:format)
  // function(id, options)
  edit_file_upload_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"file_uploads",false],[2,[7,"/",false],[2,[3,"id",false],[2,[7,"/",false],[2,[6,"edit",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// edit_page => /pages/:id/edit(.:format)
  // function(id, options)
  edit_page_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"pages",false],[2,[7,"/",false],[2,[3,"id",false],[2,[7,"/",false],[2,[6,"edit",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// edit_user_password => /users/password/edit(.:format)
  // function(options)
  edit_user_password_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"users",false],[2,[7,"/",false],[2,[6,"password",false],[2,[7,"/",false],[2,[6,"edit",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// edit_user_registration => /users/edit(.:format)
  // function(options)
  edit_user_registration_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"users",false],[2,[7,"/",false],[2,[6,"edit",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// file_upload => /file_uploads/:id(.:format)
  // function(id, options)
  file_upload_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"file_uploads",false],[2,[7,"/",false],[2,[3,"id",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// file_uploads => /file_uploads(.:format)
  // function(options)
  file_uploads_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"file_uploads",false],[1,[2,[8,".",false],[3,"format",false]],false]]], arguments),
// new_file_upload => /file_uploads/new(.:format)
  // function(options)
  new_file_upload_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"file_uploads",false],[2,[7,"/",false],[2,[6,"new",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// new_page => /pages/new(.:format)
  // function(options)
  new_page_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"pages",false],[2,[7,"/",false],[2,[6,"new",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// new_user_password => /users/password/new(.:format)
  // function(options)
  new_user_password_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"users",false],[2,[7,"/",false],[2,[6,"password",false],[2,[7,"/",false],[2,[6,"new",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// new_user_registration => /users/sign_up(.:format)
  // function(options)
  new_user_registration_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"users",false],[2,[7,"/",false],[2,[6,"sign_up",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// new_user_session => /users/sign_in(.:format)
  // function(options)
  new_user_session_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"users",false],[2,[7,"/",false],[2,[6,"sign_in",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// page => /pages/:id(.:format)
  // function(id, options)
  page_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"pages",false],[2,[7,"/",false],[2,[3,"id",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// pages => /pages(.:format)
  // function(options)
  pages_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"pages",false],[1,[2,[8,".",false],[3,"format",false]],false]]], arguments),
// rails_info => /rails/info(.:format)
  // function(options)
  rails_info_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"rails",false],[2,[7,"/",false],[2,[6,"info",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// rails_info_properties => /rails/info/properties(.:format)
  // function(options)
  rails_info_properties_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"rails",false],[2,[7,"/",false],[2,[6,"info",false],[2,[7,"/",false],[2,[6,"properties",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// rails_info_routes => /rails/info/routes(.:format)
  // function(options)
  rails_info_routes_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"rails",false],[2,[7,"/",false],[2,[6,"info",false],[2,[7,"/",false],[2,[6,"routes",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// rails_mailers => /rails/mailers(.:format)
  // function(options)
  rails_mailers_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"rails",false],[2,[7,"/",false],[2,[6,"mailers",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// root => /
  // function(options)
  root_path: Utils.route([], [], [7,"/",false], arguments),
// user_password => /users/password(.:format)
  // function(options)
  user_password_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"users",false],[2,[7,"/",false],[2,[6,"password",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// user_registration => /users(.:format)
  // function(options)
  user_registration_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"users",false],[1,[2,[8,".",false],[3,"format",false]],false]]], arguments),
// user_session => /users/sign_in(.:format)
  // function(options)
  user_session_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"users",false],[2,[7,"/",false],[2,[6,"sign_in",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments)}
;
    root.Routes.options = defaults;
    return root.Routes;
  };

  if (typeof define === "function" && define.amd) {
    define([], function() {
      return createGlobalJsRoutesObject();
    });
  } else {
    createGlobalJsRoutesObject();
  }

}).call(this);
