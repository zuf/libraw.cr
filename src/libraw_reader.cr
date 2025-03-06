require "./libraw_types"
require "./libraw"

require "colorize"

class LibRawReader
  enum ExifTag
    INTEROPERABILITY_INDEX                   = 0x0001
    INTEROPERABILITY_VERSION                 = 0x0002
    NEW_SUBFILE_TYPE                         = 0x00fe
    IMAGE_WIDTH                              = 0x0100
    IMAGE_LENGTH                             = 0x0101
    BITS_PER_SAMPLE                          = 0x0102
    COMPRESSION                              = 0x0103
    PHOTOMETRIC_INTERPRETATION               = 0x0106
    FILL_ORDER                               = 0x010a
    DOCUMENT_NAME                            = 0x010d
    IMAGE_DESCRIPTION                        = 0x010e
    MAKE                                     = 0x010f
    MODEL                                    = 0x0110
    STRIP_OFFSETS                            = 0x0111
    ORIENTATION                              = 0x0112
    SAMPLES_PER_PIXEL                        = 0x0115
    ROWS_PER_STRIP                           = 0x0116
    STRIP_BYTE_COUNTS                        = 0x0117
    X_RESOLUTION                             = 0x011a
    Y_RESOLUTION                             = 0x011b
    PLANAR_CONFIGURATION                     = 0x011c
    RESOLUTION_UNIT                          = 0x0128
    TRANSFER_FUNCTION                        = 0x012d
    SOFTWARE                                 = 0x0131
    DATE_TIME                                = 0x0132
    ARTIST                                   = 0x013b
    WHITE_POINT                              = 0x013e
    PRIMARY_CHROMATICITIES                   = 0x013f
    SUB_IFDS                                 = 0x014a
    TRANSFER_RANGE                           = 0x0156
    JPEG_PROC                                = 0x0200
    JPEG_INTERCHANGE_FORMAT                  = 0x0201
    JPEG_INTERCHANGE_FORMAT_LENGTH           = 0x0202
    YCBCR_COEFFICIENTS                       = 0x0211
    YCBCR_SUB_SAMPLING                       = 0x0212
    YCBCR_POSITIONING                        = 0x0213
    REFERENCE_BLACK_WHITE                    = 0x0214
    XML_PACKET                               = 0x02bc
    RELATED_IMAGE_FILE_FORMAT                = 0x1000
    RELATED_IMAGE_WIDTH                      = 0x1001
    RELATED_IMAGE_LENGTH                     = 0x1002
    IMAGE_DEPTH                              = 0x80e5
    CFA_REPEAT_PATTERN_DIM                   = 0x828d
    CFA_PATTERN                              = 0x828e
    BATTERY_LEVEL                            = 0x828f
    COPYRIGHT                                = 0x8298
    EXPOSURE_TIME                            = 0x829a
    FNUMBER                                  = 0x829d
    IPTC_NAA                                 = 0x83bb
    IMAGE_RESOURCES                          = 0x8649
    EXIF_IFD_POINTER                         = 0x8769
    INTER_COLOR_PROFILE                      = 0x8773
    EXPOSURE_PROGRAM                         = 0x8822
    SPECTRAL_SENSITIVITY                     = 0x8824
    GPS_INFO_IFD_POINTER                     = 0x8825
    ISO_SPEED_RATINGS                        = 0x8827
    OECF                                     = 0x8828
    TIME_ZONE_OFFSET                         = 0x882a
    SENSITIVITY_TYPE                         = 0x8830
    STANDARD_OUTPUT_SENSITIVITY              = 0x8831
    RECOMMENDED_EXPOSURE_INDEX               = 0x8832
    ISO_SPEED                                = 0x8833
    ISO_SPEEDLatitudeYYY                     = 0x8834
    ISO_SPEEDLatitudeZZZ                     = 0x8835
    EXIF_VERSION                             = 0x9000
    DATE_TIME_ORIGINAL                       = 0x9003
    DATE_TIME_DIGITIZED                      = 0x9004
    OFFSET_TIME                              = 0x9010
    OFFSET_TIME_ORIGINAL                     = 0x9011
    OFFSET_TIME_DIGITIZED                    = 0x9012
    COMPONENTS_CONFIGURATION                 = 0x9101
    COMPRESSED_BITS_PER_PIXEL                = 0x9102
    SHUTTER_SPEED_VALUE                      = 0x9201
    APERTURE_VALUE                           = 0x9202
    BRIGHTNESS_VALUE                         = 0x9203
    EXPOSURE_BIAS_VALUE                      = 0x9204
    MAX_APERTURE_VALUE                       = 0x9205
    SUBJECT_DISTANCE                         = 0x9206
    METERING_MODE                            = 0x9207
    LIGHT_SOURCE                             = 0x9208
    FLASH                                    = 0x9209
    FOCAL_LENGTH                             = 0x920a
    SUBJECT_AREA                             = 0x9214
    TIFF_EP_STANDARD_ID                      = 0x9216
    MAKER_NOTE                               = 0x927c
    USER_COMMENT                             = 0x9286
    SUB_SEC_TIME                             = 0x9290
    SUB_SEC_TIME_ORIGINAL                    = 0x9291
    SUB_SEC_TIME_DIGITIZED                   = 0x9292
    XP_TITLE                                 = 0x9c9b
    XP_COMMENT                               = 0x9c9c
    XP_AUTHOR                                = 0x9c9d
    XP_KEYWORDS                              = 0x9c9e
    XP_SUBJECT                               = 0x9c9f
    FLASH_PIX_VERSION                        = 0xa000
    COLOR_SPACE                              = 0xa001
    PIXEL_X_DIMENSION                        = 0xa002
    PIXEL_Y_DIMENSION                        = 0xa003
    RELATED_SOUND_FILE                       = 0xa004
    INTEROPERABILITY_IFD_POINTER             = 0xa005
    FLASH_ENERGY                             = 0xa20b
    SPATIAL_FREQUENCY_RESPONSE               = 0xa20c
    FOCAL_PLANE_X_RESOLUTION                 = 0xa20e
    FOCAL_PLANE_Y_RESOLUTION                 = 0xa20f
    FOCAL_PLANE_RESOLUTION_UNIT              = 0xa210
    SUBJECT_LOCATION                         = 0xa214
    EXPOSURE_INDEX                           = 0xa215
    SENSING_METHOD                           = 0xa217
    FILE_SOURCE                              = 0xa300
    SCENE_TYPE                               = 0xa301
    NEW_CFA_PATTERN                          = 0xa302
    CUSTOM_RENDERED                          = 0xa401
    EXPOSURE_MODE                            = 0xa402
    WHITE_BALANCE                            = 0xa403
    DIGITAL_ZOOM_RATIO                       = 0xa404
    FOCAL_LENGTH_IN_35MM_FILM                = 0xa405
    SCENE_CAPTURE_TYPE                       = 0xa406
    GAIN_CONTROL                             = 0xa407
    CONTRAST                                 = 0xa408
    SATURATION                               = 0xa409
    SHARPNESS                                = 0xa40a
    DEVICE_SETTING_DESCRIPTION               = 0xa40b
    SUBJECT_DISTANCE_RANGE                   = 0xa40c
    IMAGE_UNIQUE_ID                          = 0xa420
    CAMERA_OWNER_NAME                        = 0xa430
    BODY_SERIAL_NUMBER                       = 0xa431
    LENS_SPECIFICATION                       = 0xa432
    LENS_MAKE                                = 0xa433
    LENS_MODEL                               = 0xa434
    LENS_SERIAL_NUMBER                       = 0xa435
    COMPOSITE_IMAGE                          = 0xa460
    SOURCE_IMAGE_NUMBER_OF_COMPOSITE_IMAGE   = 0xa461
    SOURCE_EXPOSURE_TIMES_OF_COMPOSITE_IMAGE = 0xa462
    GAMMA                                    = 0xa500
    PRINT_IMAGE_MATCHING                     = 0xc4a5
    PADDING                                  = 0xea1c
  end

  enum ExifTagType # https://web.archive.org/web/20190624045241if_/http://www.cipa.jp:80/std/documents/e/DC-008-Translation-2019-E.pdf
    BYTE      =  1 # UInt8           An 8-bit unsigned integer
    ASCII     =  2 # String          An 8-bit byte containing one 7-bit ASCII code. The final byte is terminated with NULL.
    SHORT     =  3 # UInt16          A 16-bit (2-byte) unsigned integer
    LONG      =  4 # UInt32          A 32-bit (4-byte) unsigned integer
    RATIONAL  =  5 # {UInt32,Uint32} Two LONGs. The first LONG is the numerator and the second LONG expresses the denominator
    UNDEFINED =  7 # UInt8           An 8-bit byte that may take any value depending on the field definition
    SLONG     =  9 # Int32           (4-byte) signed integer (2's complement notation).
    SRATIONAL = 10 # {Int32,Int32}   Two SLONGs. The first SLONG is the numerator and the second SLONG is the denominator.
  end

  struct Rational    
    def initialize(@num : UInt32, @denom : UInt32)
    end

    def to_s(io : IO)
      io << @num
      io << '/'
      io << @denom
      io << " ("
      io <<  @num / @denom
      io << ")"

      if @denom == 65536
        io << " {"
        io <<  (@num // 65536)
        io << '/'
        io <<  (@denom // 65536)
        io << "}"
      end
    end
  end

  struct SRational    
    def initialize(@num : Int32, @denom : Int32)
    end

    def to_s(io : IO)
      io << @num
      io << '/'
      io << @denom
      io << " ("
      io <<  @num / @denom
      io << ")"

      if @denom == 65536
        io << " {"
        io <<  (@num // 65536)
        io << '/'
        io <<  (@denom // 65536)
        io << "}"
      end
    end
  end


  @tumbnail_bytes : Bytes?
  @file_size : Int64
  @mmap_view : Void* | Nil
  @libraw : LibRaw

  getter! libraw

  # def initialize(file_path : String)
  #   @libraw = LibRaw.new file_path
  # end

  def initialize
    @libraw = LibRaw.new
    @file_size = 0_i64
  end

  def initialize(file_path : String)
    @libraw = LibRaw.new
    @file_size = File.size(file_path)

    # Parameters:

    # context: user-specified context, set via set_exifparser_handler()
    # tag: 16-bit of TIFF/EXIF tag or'ed with
    #     0 - for EXIF parsing
    #     0x20000 - for Kodak makernotes parsing
    #     0x30000 - for Panasonic makernotes parsing
    #     0x40000 - for EXIF Interop IFD parsing
    #     0x50000 - for EXIF GPS IFD parsing
    #     (ifdN + 1) << 20) - for TIFF ifdN
    # type: tag type (see TIFF/EXIF specs)
    # len: tag length
    # ord: byte order: 0x4949 for intel, 0x4d4d for motorola
    # ifp: pointer to LibRaw_abstract_datastream input stream, positioned to start of data. There is no need to restore data position in callback.
    callback = ->(ctx : Void*, tag : Int32, type : Int32, len : Int32, ord : UInt32, ifp_ptr : Void*, base : Int64) do
      tiff_tag = tag & 0x0fffff # Undo (ifdN + 1) << 20)
      ds = ifp_ptr.as(LibRawC::BufferDatastream*).value
      exif_tag = ExifTag.from_value?(tag) || ExifTag.from_value?(tiff_tag)
      exif_type = ExifTagType.from_value(type)

      byte_format = ord == 0x4d4d ? IO::ByteFormat::BigEndian : IO::ByteFormat::LittleEndian

      io = ds.io

      exif_value = case exif_type
                   when .byte?
                     UInt8.from_io(io, format: byte_format)
                   when .ascii?
                     ds.gets(len)
                   when .short?
                     UInt16.from_io(io, format: byte_format)
                   when .long?
                     UInt32.from_io(io, format: byte_format)
                   when .rational?
                     num = UInt32.from_io(io, format: byte_format)
                     denom = UInt32.from_io(io, format: byte_format)
                     Rational.new num: num, denom: denom                     
                   when .undefined?
                     UInt8.from_io(io, format: byte_format)
                   when .slong?
                     UInt32.from_io(io, format: byte_format)
                   when .srational?
                     num = Int32.from_io(io, format: byte_format)
                     denom = Int32.from_io(io, format: byte_format)
                     SRational.new num: num, denom: denom                     
                   end

      r = Box(typeof(self)).unbox(ctx)

      STDERR.puts "EXIF: exif_tag=#{exif_tag || "???"} tag=0x#{tag.to_s(16)} tiff_tag=0x#{tiff_tag.to_s(16)} exif_type=#{exif_type} type=#{type}, len=#{len}, ord=#{ord}, base=#{base} | DS: pos=#{ds.pos} size=#{ds.size}".colorize(:dark_gray)
        if len <= 280
          STDERR.puts "#{exif_tag || "0x#{tag.to_s(16)}"} = #{exif_value}"
        else
          STDERR.puts "#{exif_tag || "0x#{tag.to_s(16)}"} = [...] | len: #{len.humanize}"
        end
  

      # if (tag == 0x9003 && type == 2 && len >= 19)
      #   STDERR.print "DATE_TIME_ORIGIN:"
      #   STDERR.puts ds.gets(len)
      #   return
      # end
      nil
    end

    @libraw.set_exifparser_handler callback, Box.box(self)

    open file_path
  end

  def open(file_path : String)
    free_mmap

    @file_size = File.size(file_path)
    File.open(file_path, "r") do |f|
      m = LibC.mmap(nil, @file_size, LibC::PROT_READ, LibC::MAP_PRIVATE, f.fd, 0_u64)
      raise RuntimeError.from_errno("Cannot map memory (length=#{@file_size.humanize_bytes})") if m == LibC::MAP_FAILED || m == nil
      @mmap_view = m
    end

    mmap_view = @mmap_view
    raise RuntimeError.from_errno("Cannot map memory (length=#{@file_size.humanize_bytes})") if mmap_view.nil?

    @raw_data = mmap_view.as(Pointer(UInt8))

    @libraw.open_buffer mmap_view, @file_size.to_u64
  end

  def free_mmap
    if mmap_view = @mmap_view
      result = LibC.munmap(mmap_view, @file_size) unless mmap_view == LibC::MAP_FAILED
      raise RuntimeError.from_errno("Cannot free mappend memory via munmap") if result != 0
      @mmap_view = nil
    end
  end

  def finalize
    free_mmap
  end

  def unpack_thumb!
    libraw.unpack_thumb
  end

  def thumbnail
    libraw.thumbnail
  end

  def thumbnail_bytes : Bytes
    tumbnail_bytes = @tumbnail_bytes
    return tumbnail_bytes if tumbnail_bytes

    tumbnail_bytes = @libraw.tumbnail_bytes
    @tumbnail_bytes = tumbnail_bytes
    tumbnail_bytes
  end

  def unpack!(half_size = false)
    params = libraw.params
    params.half_size = half_size ? 1 : 0
    params.use_camera_wb = 1
    params.output_bps = 8
    params.no_auto_bright = 1
    libraw.params = params

    libraw.unpack
  end

  def process
  end

  def recycle!
    libraw.recycle!
  end
end
