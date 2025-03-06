require "./libraw_const"
require "./libraw_types"
require "./libraw_functions"

# LibRaw official docs: https://www.libraw.org

class LibRawException < Exception; end

class LibRawNullPointerException < LibRawException; end

class LibRawError < LibRawException; end

class LibRaw
  LIBRAW_VERSION_WANTED = {0, 21, 3}

  def self.warn_about_incompatible_versions!
    STDERR.puts "WARN Possible incompatible version of #{LibRaw}. LibRaw crystal wrapper was adopted for v#{LIBRAW_VERSION_WANTED.join(".")}. Use env var LIBRAW_VERSION_WANTED=0 to skip this warning." unless LibRaw.check_version(*LIBRAW_VERSION_WANTED)
  end

  @[AlwaysInline]
  def self.check_version(major, minor, patch)
    (version_number >= make_version(major, minor, patch))
  end

  @[AlwaysInline]
  def self.make_version(major, minor, patch)
    (((major) << 16) | ((minor) << 8) | (patch))
  end

  @[AlwaysInline]
  def self.version
    String.new LibRawC.libraw_version
  end

  @[AlwaysInline]
  def self.version_number
    LibRawC.libraw_versionNumber
  end

  def self.to_s(io : IO)
    io << "LibRaw v#{version} (#{version_number})"
  end

  @[AlwaysInline]
  def self.fatal_error?(error_code)
    error_code < -100000
  end

  @[AlwaysInline]
  def self.capabilities
    LibRawC.libraw_capabilities
  end

  @[AlwaysInline]
  def self.camera_count
    LibRawC.libraw_cameraCount
  end

  @[AlwaysInline]
  def self.camera_list
    c_array = LibRawC.libraw_cameraList
    result = [] of String
    i = 0
    loop do
      current_ptr = c_array[i]
      break if current_ptr.null?

      result << String.new(current_ptr)

      i += 1
    end

    result
  end

  def self.error(error_code)
    String.new LibRawC.libraw_strerror(error_code)
  end

  @[AlwaysInline]
  def error(error_code)
    self.class.error(error_code)
  end

  getter data_t_ptr

  def initialize(flags = LibRawC::ConstructorFlags::LIBRAW_OPTIONS_NONE)
    @data_t_ptr = LibRawC.libraw_init(flags)
    raise "Cant init libraw" if @data_t_ptr == nil
  end

  def initialize(fine_path : String, flags = LibRawC::ConstructorFlags::LIBRAW_OPTIONS_NONE)
    @data_t_ptr = LibRawC.libraw_init(flags)
    raise "Cant init libraw" if @data_t_ptr == nil

    open_file(fine_path)
  end

  def initialize(bytes : Bytes, flags = LibRawC::ConstructorFlags::LIBRAW_OPTIONS_NONE)
    @data_t_ptr = LibRawC.libraw_init(flags)
    raise "Cant init libraw" if @data_t_ptr == nil

    open_bytes(bytes)
  end

  def initialize(buffer : Void*, bufsize : LibC::SizeT, flags = LibRawC::ConstructorFlags::LIBRAW_OPTIONS_NONE)
    @data_t_ptr = LibRawC.libraw_init(flags)
    raise "Cant init libraw" if @data_t_ptr == nil

    open_buffer(buffer, bufsize)
  end

  def finalize
    LibRawC.libraw_close(@data_t_ptr)
  end

  def to_unsafe
    @data_t_ptr
  end

  def recycle!
    LibRawC.libraw_recycle(@data_t_ptr) unless @data_t_ptr == nil
  end

  def recycle_datastream!
    LibRawC.libraw_recycle_datastream(@data_t_ptr) unless @data_t_ptr == nil
  end

  def open_file(file : String)
    check_error! LibRawC.libraw_open_file(@data_t_ptr, file)
    # raise "ERROR LibRaw: Cannot open #{file}: #{error(ret)}" if ret != LibRawC::Errors::LIBRAW_SUCCESS # unless ret.success?
  end

  def open_bytes(buffer : Bytes)
    check_error! LibRawC.libraw_open_buffer(@data_t_ptr, buffer, buffer.size)
    # raise "ERROR LibRaw: Cannot read #{buffer.size} bytes from buffer: #{error(ret)}" if ret != LibRawC::Errors::LIBRAW_SUCCESS # unless ret.success?
  end

  def open_buffer(buffer : Void*, bufsize : LibC::SizeT)
    check_error! LibRawC.libraw_open_buffer(@data_t_ptr, buffer, bufsize)
    # raise "ERROR LibRaw: Cannot read #{bufsize} bytes from buffer: #{error(ret)}" if ret != LibRawC::Errors::LIBRAW_SUCCESS # unless ret.success?
  end

  def unpack
    check_error! LibRawC.libraw_unpack(@data_t_ptr)
    # raise "ERROR LibRaw: Cannot unpack raw image: #{error(ret)}" if ret != LibRawC::Errors::LIBRAW_SUCCESS # unless ret.success?
  end

  def unpack_thumb
    check_error! LibRawC.libraw_unpack_thumb(@data_t_ptr)
    # raise "ERROR LibRaw: Cannot unpack thumbnail: #{error(ret)}" if ret != LibRawC::Errors::LIBRAW_SUCCESS # unless ret.success?
  end

  def unpack_thumb_ex(thumb_index : Int32)
    check_error! LibRawC.libraw_unpack_thumb_ex(@data_t_ptr, thumb_index)
    # raise "ERROR LibRaw: Cannot unpack thumbnail ##{thumb_index}: #{error(ret)}" if ret != LibRawC::Errors::LIBRAW_SUCCESS # unless ret.success?
  end

  def dcraw_thumb_writer(file_name : String)
    check_error! LibRawC.libraw_dcraw_thumb_writer(@data_t_ptr, file_name)
    # raise "ERROR LibRaw: Cannot unpack_thumb: #{error(ret)}" if ret != LibRawC::Errors::LIBRAW_SUCCESS # unless ret.success?
  end

  @[AlwaysInline]
  def image
    @data_t_ptr.value.image
  end

  @[AlwaysInline]
  def sizes
    @data_t_ptr.value.sizes
  end

  @[AlwaysInline]
  def idata
    @data_t_ptr.value.idata
  end

  @[AlwaysInline]
  def idata
    @data_t_ptr.value.lens
  end

  @[AlwaysInline]
  def makernotes
    @data_t_ptr.value.makernotes
  end

  @[AlwaysInline]
  def shootinginfo
    @data_t_ptr.value.shootinginfo
  end

  @[AlwaysInline]
  def params
    @data_t_ptr.value.params
  end

  @[AlwaysInline]
  def params=(new_params)
    @data_t_ptr.value.params = new_params
  end

  @[AlwaysInline]
  def rawparams
    @data_t_ptr.value.rawparams
  end

  @[AlwaysInline]
  def progress_flags
    @data_t_ptr.value.progress_flags
  end

  @[AlwaysInline]
  def process_warnings
    @data_t_ptr.value.process_warnings
  end

  @[AlwaysInline]
  def color
    @data_t_ptr.value.color
  end

  @[AlwaysInline]
  def other
    @data_t_ptr.value.other
  end

  @[AlwaysInline]
  def thumbnail
    @data_t_ptr.value.thumbnail
  end

  @[AlwaysInline]
  def thumbs_list
    @data_t_ptr.value.thumbs_list
  end

  @[AlwaysInline]
  def rawdata
    @data_t_ptr.value.rawdata
  end

  @[AlwaysInline]
  def parent_class
    @data_t_ptr.value.parent_class
  end

  def raw_height
    LibRawC.libraw_get_raw_height(@data_t_ptr)
  end

  def raw_width
    LibRawC.libraw_get_raw_width(@data_t_ptr)
  end

  def iheight
    LibRawC.libraw_get_iheight(@data_t_ptr)
  end

  def iwidth
    LibRawC.libraw_get_iwidth(@data_t_ptr)
  end

  def cam_mul(index : Int32)
    LibRawC.libraw_get_cam_mul(@data_t_ptr, index)
  end

  def pre_mul(index : Int32)
    LibRawC.libraw_get_pre_mul(@data_t_ptr, index)
  end

  def rgb_cam(index1 : Int32, index2 : Int32)
    LibRawC.libraw_get_rgb_cam(@data_t_ptr, index1, index2)
  end

  def iparams
    ptr = check_error! LibRawC.libraw_get_iparams(@data_t_ptr)
    ptr.value
  end

  def lensinfo
    ptr = check_error! LibRawC.libraw_get_lensinfo(@data_t_ptr)
    ptr.value
  end

  def imgother
    ptr = check_error! LibRawC.libraw_get_imgother(@data_t_ptr)
    ptr.value
  end

  def color_maximum
    LibRawC.libraw_get_color_maximum(@data_t_ptr)
  end

  def set_user_mul(index : Int32, val : Float32)
    LibRawC.libraw_set_user_mul(@data_t_ptr, index, val)
  end

  def demosaic=(value : Int32)
    LibRawC.libraw_set_demosaic(@data_t_ptr, value)
  end

  def adjust_maximum_thr=(value : Float32)
    LibRawC.libraw_set_adjust_maximum_thr(@data_t_ptr, value)
  end

  def output_color=(value : Int32)
    LibRawC.libraw_set_output_color(@data_t_ptr, value)
  end

  def output_bps=(value : Int32)
    LibRawC.libraw_set_output_bps(@data_t_ptr, value)
  end

  def set_gamma(index : Int32, value : Float32)
    LibRawC.libraw_set_gamma(@data_t_ptr, index, value)
  end

  def no_auto_bright=(value : Int32)
    LibRawC.libraw_set_no_auto_bright(@data_t_ptr, value)
  end

  def bright=(value : Float32)
    LibRawC.libraw_set_bright(@data_t_ptr, value)
  end

  def highlight=(value : Int32)
    LibRawC.libraw_set_highlight(@data_t_ptr, value)
  end

  def fbdd_noiserd=(value : Int32)
    LibRawC.libraw_set_fbdd_noiserd(@data_t_ptr, value)
  end

  def decoder_info(decoder_info : DecoderInfoT*)
    check_error! LibRawC.libraw_get_decoder_info(@data_t_ptr, decoder_info)
  end

  def unpack_function_name
    ptr = check_error! LibRawC.libraw_unpack_function_name(@data_t_ptr)
    String.new(ptr)
  end

  # This call returns pixel color (color component number) in bayer pattern at row,col. The returned value is in 0..3 range for 4-component Bayer (RGBG2, CMYG and so on) and in 0..2 range for 3-color data.
  # Color indexes returned could be used as index in imgdata.idata.cdesc string to get color 'name'.
  def color(row : Int32, col : Int32) : Int32
    LibRawC.libraw_COLOR(@data_t_ptr, row, col)
  end

  def subtract_black
    LibRawC.libraw_subtract_black(@data_t_ptr)
  end

  def self.strprogress(progress)
    LibRawC.libraw_strprogress(progress)
  end

  def dataerror_handler(progress, func : DataCallback, data : Void*)
    LibRawC.libraw_set_dataerror_handler(@data_t_ptr, func, data)
  end

  def progress_handler(progress, func : ProgressCallback, data : Void*)
    LibRawC.libraw_set_progress_handler(@data_t_ptr, func, data)
  end

  def set_exifparser_handler(callback : LibRawC::ExifParserCallback, data : Void*)
    LibRawC.libraw_set_exifparser_handler(@data_t_ptr, callback, data)
  end

  def raw2image
    check_error! LibRawC.libraw_raw2image(@data_t_ptr)
  end

  def free_image
    check_error! LibRawC.libraw_free_image(@data_t_ptr)
  end

  def adjust_sizes_info_only
    check_error! LibRawC.libraw_adjust_sizes_info_only(@data_t_ptr)
  end

  def dcraw_process
    check_error! LibRawC.libraw_dcraw_process(@data_t_ptr)
  end

  def half_size=(half_size : Boolean)
    # @data_t_ptr.value.imgdata.params.use_camera_wb = 1;
    # @data_t_ptr.value.imgdata.params.output_bps = 8;
    # @data_t_ptr.value.imgdata.params.no_auto_bright = 1;

    @data_t_ptr.value.imgdata.params.half_size = half_size ? 1 : 0
  end

  def tumbnail_bytes
    Bytes.new(thumbnail.thumb, thumbnail.tlength)
  end

  def dcraw_ppm_tiff_writer(filename)
    check_error! LibRawC.libraw_dcraw_ppm_tiff_writer(@data_t_ptr, filename)
  end

  def dcraw_thumb_writer(fname)
    check_error! LibRawC.libraw_dcraw_thumb_writer(@data_t_ptr, fname)
  end

  def dcraw_make_mem_image(errcode : Int32*)
    check_null_pointer! LibRawC.libraw_dcraw_make_mem_image(@data_t_ptr, errcode)
  end

  def dcraw_make_mem_thumb(errcode : Int32*)
    check_null_pointer! LibRawC.libraw_dcraw_make_mem_thumb(@data_t_ptr, errcode)
  end

  def dcraw_clear_mem(processed_image)
    LibRawC.libraw_dcraw_clear_mem(processed_image)
  end

  private def check_null_pointer!(ptr : Pointer)
    raise LibRawNullPointerException.new("NULL pointer returned: #{ptr}") if ptr == nil || ptr.null?
    ptr
  end

  private def check_error!(ptr : Pointer)
    check_null_pointer!(ptr)
  end

  private def check_error!(error_code : LibRawC::Errors | Int32)
    # TODO Use macro LIBRAW_FATAL_ERROR(error code) checks if an error is fatal or not
    if error_code.is_a? LibRawC::Errors
      ec = error_code
    else
      ec = LibRawC::Errors.new error_code
    end

    raise LibRawError.new("ERROR LibRaw: #{error(ec)}") if ec != LibRawC::Errors::LIBRAW_SUCCESS # unless ret.success?
    error_code
  end
end

LibRaw.warn_about_incompatible_versions! if ENV.fetch("LIBRAWCR_NO_VERSION_VARNING") { "1" } == "1"
