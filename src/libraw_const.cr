@[Link("libraw_r")]
lib LibRawC
  LIBRAW_DEFAULT_ADJUST_MAXIMUM_THRESHOLD  = 0.75_f32
  LIBRAW_DEFAULT_AUTO_BRIGHTNESS_THRESHOLD = 0.01_f32

  #  limit allocation size, default is 2Gb
  LIBRAW_MAX_ALLOC_MB_DEFAULT = 2048_i64

  LIBRAW_MAX_PROFILE_SIZE_MB = 256_i64

  LIBRAW_MAX_NONDNG_RAW_FILE_SIZE = 2147483647_u64

  # ifndef LIBRAW_MAX_DNG_RAW_FILE_SIZE
  # ifdef USE_DNGSDK
  # define LIBRAW_MAX_DNG_RAW_FILE_SIZE 4294967295ULL
  # else
  # define LIBRAW_MAX_DNG_RAW_FILE_SIZE 2147483647ULL
  # endif
  # endif

  # /* limit thumbnail size, default is 512Mb*/
  # ifndef LIBRAW_MAX_THUMBNAIL_MB
  LIBRAW_MAX_THUMBNAIL_MB = 512_i64
  # endif

  # /* Check if enough file space exists before tag read */
  # ifndef LIBRAW_NO_IOSPACE_CHECK
  # define LIBRAW_IOSPACE_CHECK
  # endif
  # ifndef LIBRAW_NO_CR3_MEMPOOL
  # define LIBRAW_CR3_MEMPOOL
  # endif

  # /* LibRaw uses own memory pool management, with LIBRAW_MSIZE (512)
  # entries. It is enough for parsing/decoding non-damaged files, but
  # may overflow on specially crafted files (eg. with many string values
  # like XMP blocks.
  # LIBRAW_MEMPOOL_CHECK define will result in error on pool overflow */
  # ifndef LIBRAW_NO_MEMPOOL_CHECK
  # define LIBRAW_MEMPOOL_CHECK
  # endif

  LIBRAW_MAX_METADATA_BLOCKS = 1024
  LIBRAW_CBLACK_SIZE         = 4104
  LIBRAW_IFD_MAXCOUNT        =   10
  LIBRAW_THUMBNAIL_MAXCOUNT  =    8
  LIBRAW_CRXTRACKS_MAXCOUNT  =   16
  LIBRAW_AFDATA_MAXCOUNT     =    4
  LIBRAW_AHD_TILE            =  512
  # LIBRAW_NO_IOSTREAMS_DATASTREAM

  enum OpenFlags
    LIBRAW_OPEN_BIGFILE = 1
    LIBRAW_OPEN_FILE    = 1 << 1
  end

  enum OpenbayerPatterns
    LIBRAW_OPENBAYER_RGGB = 0x94
    LIBRAW_OPENBAYER_BGGR = 0x16
    LIBRAW_OPENBAYER_GRBG = 0x61
    LIBRAW_OPENBAYER_GBRG = 0x49
  end

  enum DngfieldsMarks
    LIBRAW_DNGFM_FORWARDMATRIX       = 1
    LIBRAW_DNGFM_ILLUMINANT          = 1 << 1
    LIBRAW_DNGFM_COLORMATRIX         = 1 << 2
    LIBRAW_DNGFM_CALIBRATION         = 1 << 3
    LIBRAW_DNGFM_ANALOGBALANCE       = 1 << 4
    LIBRAW_DNGFM_BLACK               = 1 << 5
    LIBRAW_DNGFM_WHITE               = 1 << 6
    LIBRAW_DNGFM_OPCODE2             = 1 << 7
    LIBRAW_DNGFM_LINTABLE            = 1 << 8
    LIBRAW_DNGFM_CROPORIGIN          = 1 << 9
    LIBRAW_DNGFM_CROPSIZE            = 1 << 10
    LIBRAW_DNGFM_PREVIEWCS           = 1 << 11
    LIBRAW_DNGFM_ASSHOTNEUTRAL       = 1 << 12
    LIBRAW_DNGFM_BASELINEEXPOSURE    = 1 << 13
    LIBRAW_DNGFM_LINEARRESPONSELIMIT = 1 << 14
    LIBRAW_DNGFM_USERCROP            = 1 << 15
    LIBRAW_DNGFM_OPCODE1             = 1 << 16
    LIBRAW_DNGFM_OPCODE3             = 1 << 17
  end

  enum AsShotWBAppliedCodes
    LIBRAW_ASWB_APPLIED    =  1
    LIBRAW_ASWB_CANON      =  2
    LIBRAW_ASWB_NIKON      =  4
    LIBRAW_ASWB_NIKON_SRAW =  8
    LIBRAW_ASWB_PENTAX     = 16
  end

  # define tagtypeIs(typex) (type == typex)
  enum ExifTagTypes
    LIBRAW_EXIFTAG_TYPE_UNKNOWN   =  0
    LIBRAW_EXIFTAG_TYPE_BYTE      =  1
    LIBRAW_EXIFTAG_TYPE_ASCII     =  2
    LIBRAW_EXIFTAG_TYPE_SHORT     =  3
    LIBRAW_EXIFTAG_TYPE_LONG      =  4
    LIBRAW_EXIFTAG_TYPE_RATIONAL  =  5
    LIBRAW_EXIFTAG_TYPE_SBYTE     =  6
    LIBRAW_EXIFTAG_TYPE_UNDEFINED =  7
    LIBRAW_EXIFTAG_TYPE_SSHORT    =  8
    LIBRAW_EXIFTAG_TYPE_SLONG     =  9
    LIBRAW_EXIFTAG_TYPE_SRATIONAL = 10
    LIBRAW_EXIFTAG_TYPE_FLOAT     = 11
    LIBRAW_EXIFTAG_TYPE_DOUBLE    = 12
    LIBRAW_EXIFTAG_TYPE_IFD       = 13
    LIBRAW_EXIFTAG_TYPE_UNICODE   = 14
    LIBRAW_EXIFTAG_TYPE_COMPLEX   = 15
    LIBRAW_EXIFTAG_TYPE_LONG8     = 16
    LIBRAW_EXIFTAG_TYPE_SLONG8    = 17
    LIBRAW_EXIFTAG_TYPE_IFD8      = 18
  end

  LIBRAW_EXIFTOOLTAGTYPE_int8u       = LIBRAW_EXIFTAG_TYPE_BYTE
  LIBRAW_EXIFTOOLTAGTYPE_string      = LIBRAW_EXIFTAG_TYPE_ASCII
  LIBRAW_EXIFTOOLTAGTYPE_int16u      = LIBRAW_EXIFTAG_TYPE_SHORT
  LIBRAW_EXIFTOOLTAGTYPE_int32u      = LIBRAW_EXIFTAG_TYPE_LONG
  LIBRAW_EXIFTOOLTAGTYPE_rational64u = LIBRAW_EXIFTAG_TYPE_RATIONAL
  LIBRAW_EXIFTOOLTAGTYPE_int8s       = LIBRAW_EXIFTAG_TYPE_SBYTE
  LIBRAW_EXIFTOOLTAGTYPE_undef       = LIBRAW_EXIFTAG_TYPE_UNDEFINED
  LIBRAW_EXIFTOOLTAGTYPE_binary      = LIBRAW_EXIFTAG_TYPE_UNDEFINED
  LIBRAW_EXIFTOOLTAGTYPE_int16s      = LIBRAW_EXIFTAG_TYPE_SSHORT
  LIBRAW_EXIFTOOLTAGTYPE_int32s      = LIBRAW_EXIFTAG_TYPE_SLONG
  LIBRAW_EXIFTOOLTAGTYPE_rational64s = LIBRAW_EXIFTAG_TYPE_SRATIONAL
  LIBRAW_EXIFTOOLTAGTYPE_float       = LIBRAW_EXIFTAG_TYPE_FLOAT
  LIBRAW_EXIFTOOLTAGTYPE_double      = LIBRAW_EXIFTAG_TYPE_DOUBLE
  LIBRAW_EXIFTOOLTAGTYPE_ifd         = LIBRAW_EXIFTAG_TYPE_IFD
  LIBRAW_EXIFTOOLTAGTYPE_unicode     = LIBRAW_EXIFTAG_TYPE_UNICODE
  LIBRAW_EXIFTOOLTAGTYPE_complex     = LIBRAW_EXIFTAG_TYPE_COMPLEX
  LIBRAW_EXIFTOOLTAGTYPE_int64u      = LIBRAW_EXIFTAG_TYPE_LONG8
  LIBRAW_EXIFTOOLTAGTYPE_int64s      = LIBRAW_EXIFTAG_TYPE_SLONG8
  LIBRAW_EXIFTOOLTAGTYPE_ifd64       = LIBRAW_EXIFTAG_TYPE_IFD8

  LIBRAW_LENS_NOT_SET = 0xffffffffffffffff_u64

  enum WhitebalanceCode
    # # clang-format off
    #   /*
    #       EXIF light sources
    #       12 = FL-D; Daylight fluorescent (D 5700K – 7100K) (F1,F5)
    #       13 = FL-N; Day white fluorescent (N 4600K – 5400K) (F7,F8)
    #       14 = FL-W; Cool white fluorescent (W 3900K – 4500K) (F2,F6, office, store, warehouse)
    #       15 = FL-WW; White fluorescent (WW 3200K – 3700K) (F3, residential)
    #       16 = FL-L; Soft/Warm white fluorescent (L 2600K - 3250K) (F4, kitchen, bath)
    #   */
    # #clang-format on
    LIBRAW_WBI_Unknown         =      0
    LIBRAW_WBI_Daylight        =      1
    LIBRAW_WBI_Fluorescent     =      2
    LIBRAW_WBI_Tungsten        =      3
    LIBRAW_WBI_Flash           =      4
    LIBRAW_WBI_FineWeather     =      9
    LIBRAW_WBI_Cloudy          =     10
    LIBRAW_WBI_Shade           =     11
    LIBRAW_WBI_FL_D            =     12
    LIBRAW_WBI_FL_N            =     13
    LIBRAW_WBI_FL_W            =     14
    LIBRAW_WBI_FL_WW           =     15
    LIBRAW_WBI_FL_L            =     16
    LIBRAW_WBI_Ill_A           =     17
    LIBRAW_WBI_Ill_B           =     18
    LIBRAW_WBI_Ill_C           =     19
    LIBRAW_WBI_D55             =     20
    LIBRAW_WBI_D65             =     21
    LIBRAW_WBI_D75             =     22
    LIBRAW_WBI_D50             =     23
    LIBRAW_WBI_StudioTungsten  =     24
    LIBRAW_WBI_Sunset          =     64
    LIBRAW_WBI_Underwater      =     65
    LIBRAW_WBI_FluorescentHigh =     66
    LIBRAW_WBI_HT_Mercury      =     67
    LIBRAW_WBI_AsShot          =     81
    LIBRAW_WBI_Auto            =     82
    LIBRAW_WBI_Custom          =     83
    LIBRAW_WBI_Auto1           =     85
    LIBRAW_WBI_Auto2           =     86
    LIBRAW_WBI_Auto3           =     87
    LIBRAW_WBI_Auto4           =     88
    LIBRAW_WBI_Custom1         =     90
    LIBRAW_WBI_Custom2         =     91
    LIBRAW_WBI_Custom3         =     92
    LIBRAW_WBI_Custom4         =     93
    LIBRAW_WBI_Custom5         =     94
    LIBRAW_WBI_Custom6         =     95
    LIBRAW_WBI_PC_Set1         =     96
    LIBRAW_WBI_PC_Set2         =     97
    LIBRAW_WBI_PC_Set3         =     98
    LIBRAW_WBI_PC_Set4         =     99
    LIBRAW_WBI_PC_Set5         =    100
    LIBRAW_WBI_Measured        =    110
    LIBRAW_WBI_BW              =    120
    LIBRAW_WBI_Kelvin          =    254
    LIBRAW_WBI_Other           =    255
    LIBRAW_WBI_None            = 0xffff
  end

  enum MultiExposureRelated
    LIBRAW_ME_NONE    = 0
    LIBRAW_ME_SIMPLE  = 1
    LIBRAW_ME_OVERLAY = 2
    LIBRAW_ME_HDR     = 3
  end

  enum DngProcessing
    LIBRAW_DNG_NONE    =  0
    LIBRAW_DNG_FLOAT   =  1
    LIBRAW_DNG_LINEAR  =  2
    LIBRAW_DNG_DEFLATE =  4
    LIBRAW_DNG_XTRANS  =  8
    LIBRAW_DNG_OTHER   = 16
    LIBRAW_DNG_8BIT    = 32
    # /*LIBRAW_DNG_LARGERANGE=64*/ /* more than 16 bit integer */
    LIBRAW_DNG_ALL = LIBRAW_DNG_FLOAT | LIBRAW_DNG_LINEAR | LIBRAW_DNG_DEFLATE | LIBRAW_DNG_XTRANS |
      LIBRAW_DNG_8BIT | LIBRAW_DNG_OTHER # /* |LIBRAW_DNG_LARGERANGE */
    LIBRAW_DNG_DEFAULT = LIBRAW_DNG_FLOAT | LIBRAW_DNG_LINEAR |
      LIBRAW_DNG_DEFLATE | LIBRAW_DNG_8BIT
  end

  enum OutputFlags
    LIBRAW_OUTPUT_FLAGS_NONE    = 0
    LIBRAW_OUTPUT_FLAGS_PPMMETA = 1
  end

  enum RuntimeCapabilities
    LIBRAW_CAPS_RAWSPEED      = 1
    LIBRAW_CAPS_DNGSDK        = 1 << 1
    LIBRAW_CAPS_GPRSDK        = 1 << 2
    LIBRAW_CAPS_UNICODEPATHS  = 1 << 3
    LIBRAW_CAPS_X3FTOOLS      = 1 << 4
    LIBRAW_CAPS_RPI6BY9       = 1 << 5
    LIBRAW_CAPS_ZLIB          = 1 << 6
    LIBRAW_CAPS_JPEG          = 1 << 7
    LIBRAW_CAPS_RAWSPEED3     = 1 << 8
    LIBRAW_CAPS_RAWSPEED_BITS = 1 << 9
  end

  enum Colorspace
    LIBRAW_COLORSPACE_NotFound          = 0
    LIBRAW_COLORSPACE_sRGB
    LIBRAW_COLORSPACE_AdobeRGB
    LIBRAW_COLORSPACE_WideGamutRGB
    LIBRAW_COLORSPACE_ProPhotoRGB
    LIBRAW_COLORSPACE_ICC
    LIBRAW_COLORSPACE_Uncalibrated # Tag 0x0001 InteropIndex containing "R03" + LIBRAW_COLORSPACE_Uncalibrated = Adobe RGB
    LIBRAW_COLORSPACE_CameraLinearUniWB
    LIBRAW_COLORSPACE_CameraLinear
    LIBRAW_COLORSPACE_CameraGammaUniWB
    LIBRAW_COLORSPACE_CameraGamma
    LIBRAW_COLORSPACE_MonochromeLinear
    LIBRAW_COLORSPACE_MonochromeGamma
    LIBRAW_COLORSPACE_Unknown           = 255
  end

  enum CameramakerIndex
    LIBRAW_CAMERAMAKER_Unknown      = 0
    LIBRAW_CAMERAMAKER_Agfa
    LIBRAW_CAMERAMAKER_Alcatel
    LIBRAW_CAMERAMAKER_Apple
    LIBRAW_CAMERAMAKER_Aptina
    LIBRAW_CAMERAMAKER_AVT
    LIBRAW_CAMERAMAKER_Baumer
    LIBRAW_CAMERAMAKER_Broadcom
    LIBRAW_CAMERAMAKER_Canon
    LIBRAW_CAMERAMAKER_Casio
    LIBRAW_CAMERAMAKER_CINE
    LIBRAW_CAMERAMAKER_Clauss
    LIBRAW_CAMERAMAKER_Contax
    LIBRAW_CAMERAMAKER_Creative
    LIBRAW_CAMERAMAKER_DJI
    LIBRAW_CAMERAMAKER_DXO
    LIBRAW_CAMERAMAKER_Epson
    LIBRAW_CAMERAMAKER_Foculus
    LIBRAW_CAMERAMAKER_Fujifilm
    LIBRAW_CAMERAMAKER_Generic
    LIBRAW_CAMERAMAKER_Gione
    LIBRAW_CAMERAMAKER_GITUP
    LIBRAW_CAMERAMAKER_Google
    LIBRAW_CAMERAMAKER_GoPro
    LIBRAW_CAMERAMAKER_Hasselblad
    LIBRAW_CAMERAMAKER_HTC
    LIBRAW_CAMERAMAKER_I_Mobile
    LIBRAW_CAMERAMAKER_Imacon
    LIBRAW_CAMERAMAKER_JK_Imaging
    LIBRAW_CAMERAMAKER_Kodak
    LIBRAW_CAMERAMAKER_Konica
    LIBRAW_CAMERAMAKER_Leaf
    LIBRAW_CAMERAMAKER_Leica
    LIBRAW_CAMERAMAKER_Lenovo
    LIBRAW_CAMERAMAKER_LG
    LIBRAW_CAMERAMAKER_Logitech
    LIBRAW_CAMERAMAKER_Mamiya
    LIBRAW_CAMERAMAKER_Matrix
    LIBRAW_CAMERAMAKER_Meizu
    LIBRAW_CAMERAMAKER_Micron
    LIBRAW_CAMERAMAKER_Minolta
    LIBRAW_CAMERAMAKER_Motorola
    LIBRAW_CAMERAMAKER_NGM
    LIBRAW_CAMERAMAKER_Nikon
    LIBRAW_CAMERAMAKER_Nokia
    LIBRAW_CAMERAMAKER_Olympus
    LIBRAW_CAMERAMAKER_OmniVison
    LIBRAW_CAMERAMAKER_Panasonic
    LIBRAW_CAMERAMAKER_Parrot
    LIBRAW_CAMERAMAKER_Pentax
    LIBRAW_CAMERAMAKER_PhaseOne
    LIBRAW_CAMERAMAKER_PhotoControl
    LIBRAW_CAMERAMAKER_Photron
    LIBRAW_CAMERAMAKER_Pixelink
    LIBRAW_CAMERAMAKER_Polaroid
    LIBRAW_CAMERAMAKER_RED
    LIBRAW_CAMERAMAKER_Ricoh
    LIBRAW_CAMERAMAKER_Rollei
    LIBRAW_CAMERAMAKER_RoverShot
    LIBRAW_CAMERAMAKER_Samsung
    LIBRAW_CAMERAMAKER_Sigma
    LIBRAW_CAMERAMAKER_Sinar
    LIBRAW_CAMERAMAKER_SMaL
    LIBRAW_CAMERAMAKER_Sony
    LIBRAW_CAMERAMAKER_ST_Micro
    LIBRAW_CAMERAMAKER_THL
    LIBRAW_CAMERAMAKER_VLUU
    LIBRAW_CAMERAMAKER_Xiaomi
    LIBRAW_CAMERAMAKER_XIAOYI
    LIBRAW_CAMERAMAKER_YI
    LIBRAW_CAMERAMAKER_Yuneec
    LIBRAW_CAMERAMAKER_Zeiss
    LIBRAW_CAMERAMAKER_OnePlus
    LIBRAW_CAMERAMAKER_ISG
    LIBRAW_CAMERAMAKER_VIVO
    LIBRAW_CAMERAMAKER_HMD_Global
    LIBRAW_CAMERAMAKER_HUAWEI
    LIBRAW_CAMERAMAKER_RaspberryPi
    LIBRAW_CAMERAMAKER_OmDigital

    # Insert additional indexes here
    LIBRAW_CAMERAMAKER_TheLastOne
  end

  enum CameraMounts
    LIBRAW_MOUNT_Unknown         = 0
    LIBRAW_MOUNT_Alpa
    LIBRAW_MOUNT_C # /* C-mount */
    LIBRAW_MOUNT_Canon_EF_M
    LIBRAW_MOUNT_Canon_EF_S
    LIBRAW_MOUNT_Canon_EF
    LIBRAW_MOUNT_Canon_RF
    LIBRAW_MOUNT_Contax_N
    LIBRAW_MOUNT_Contax645
    LIBRAW_MOUNT_FT      # /* original 4/3 */
    LIBRAW_MOUNT_mFT     # /* micro 4/3 */
    LIBRAW_MOUNT_Fuji_GF # /* Fujifilm GFX cameras G mount */
    LIBRAW_MOUNT_Fuji_GX # /* Fujifilm GX680 */
    LIBRAW_MOUNT_Fuji_X
    LIBRAW_MOUNT_Hasselblad_H # /* Hasselblad Hn cameras HC & HCD lenses */
    LIBRAW_MOUNT_Hasselblad_V
    LIBRAW_MOUNT_Hasselblad_XCD # /* Hasselblad Xn cameras XCD lenses */
    LIBRAW_MOUNT_Leica_M        # /* Leica rangefinder bayonet */
    LIBRAW_MOUNT_Leica_R        # /* Leica SLRs 'R' for reflex */
    LIBRAW_MOUNT_Leica_S        # /* LIBRAW_FORMAT_LeicaS 'MF' */
    LIBRAW_MOUNT_Leica_SL       # /* lens mounts on 'L' throat FF */
    LIBRAW_MOUNT_Leica_TL       # /* lens mounts on 'L' throat APS-C */
    LIBRAW_MOUNT_LPS_L          # /* Leica/Panasonic/Sigma camera mount takes L SL and TL lenses */
    LIBRAW_MOUNT_Mamiya67       # /* Mamiya RB67 RZ67 */
    LIBRAW_MOUNT_Mamiya645
    LIBRAW_MOUNT_Minolta_A
    LIBRAW_MOUNT_Nikon_CX # /* used in 'Nikon 1' series */
    LIBRAW_MOUNT_Nikon_F
    LIBRAW_MOUNT_Nikon_Z
    LIBRAW_MOUNT_PhaseOne_iXM_MV
    LIBRAW_MOUNT_PhaseOne_iXM_RS
    LIBRAW_MOUNT_PhaseOne_iXM
    LIBRAW_MOUNT_Pentax_645
    LIBRAW_MOUNT_Pentax_K
    LIBRAW_MOUNT_Pentax_Q
    LIBRAW_MOUNT_RicohModule
    LIBRAW_MOUNT_Rollei_bayonet # /* Rollei Hy-6: Leaf AFi, Sinar Hy6- models */
    LIBRAW_MOUNT_Samsung_NX_M
    LIBRAW_MOUNT_Samsung_NX
    LIBRAW_MOUNT_Sigma_X3F
    LIBRAW_MOUNT_Sony_E
    LIBRAW_MOUNT_LF
    LIBRAW_MOUNT_DigitalBack
    LIBRAW_MOUNT_FixedLens
    LIBRAW_MOUNT_IL_UM # /* Interchangeable lens, mount unknown */
    LIBRAW_MOUNT_TheLastOne
  end

  enum CameraFormats
    LIBRAW_FORMAT_Unknown      = 0
    LIBRAW_FORMAT_APSC
    LIBRAW_FORMAT_FF
    LIBRAW_FORMAT_MF
    LIBRAW_FORMAT_APSH
    LIBRAW_FORMAT_1INCH
    LIBRAW_FORMAT_1div2p3INCH # /* 1/2.3" */
    LIBRAW_FORMAT_1div1p7INCH # /* 1/1.7" */
    LIBRAW_FORMAT_FT          # /* sensor size in FT & mFT cameras */
    LIBRAW_FORMAT_CROP645     # /* 44x33mm */
    LIBRAW_FORMAT_LeicaS      # /* 'MF' Leicas */
    LIBRAW_FORMAT_645
    LIBRAW_FORMAT_66
    LIBRAW_FORMAT_69
    LIBRAW_FORMAT_LF
    LIBRAW_FORMAT_Leica_DMR
    LIBRAW_FORMAT_67
    LIBRAW_FORMAT_SigmaAPSC    # /* DP1, DP2, SD15, SD14, SD10, SD9 */
    LIBRAW_FORMAT_SigmaMerrill # /* SD1,  'SD1 Merrill',  'DP1 Merrill',  'DP2 Merrill' */
    LIBRAW_FORMAT_SigmaAPSH    # /* 'sd Quattro H' */
    LIBRAW_FORMAT_3648         # /* DALSA FTF4052C (Mamiya ZD) */
    LIBRAW_FORMAT_68           # /* Fujifilm GX680 */
    LIBRAW_FORMAT_TheLastOne
  end

  enum ImageAspects
    LIBRAW_IMAGE_ASPECT_UNKNOWN                   =     0
    LIBRAW_IMAGE_ASPECT_OTHER                     =     1
    LIBRAW_IMAGE_ASPECT_MINIMAL_REAL_ASPECT_VALUE =    99 # /* 1:10*/
    LIBRAW_IMAGE_ASPECT_MAXIMAL_REAL_ASPECT_VALUE = 10000 # /* 10: 1*/
    # Value:  width / height * 1000
    LIBRAW_IMAGE_ASPECT_3to2  = (1000 * 3) // 2
    LIBRAW_IMAGE_ASPECT_1to1  = 1000
    LIBRAW_IMAGE_ASPECT_4to3  = (1000 * 4) // 3
    LIBRAW_IMAGE_ASPECT_16to9 = (1000 * 16) // 9
    # LIBRAW_IMAGE_ASPECT_6to6, # what is the difference with 1:1 ?
    LIBRAW_IMAGE_ASPECT_5to4 = (1000 * 5) // 4
    LIBRAW_IMAGE_ASPECT_7to6 = (1000 * 7) // 6
    LIBRAW_IMAGE_ASPECT_6to5 = (1000 * 6) // 5
    LIBRAW_IMAGE_ASPECT_7to5 = (1000 * 7) // 5
  end

  enum LensFocalTypes
    LIBRAW_FT_UNDEFINED                   = 0
    LIBRAW_FT_PRIME_LENS                  = 1
    LIBRAW_FT_ZOOM_LENS                   = 2
    LIBRAW_FT_ZOOM_LENS_CONSTANT_APERTURE = 3
    LIBRAW_FT_ZOOM_LENS_VARIABLE_APERTURE = 4
  end

  enum CanonRecordModes
    LIBRAW_Canon_RecordMode_UNDEFINED  = 0
    LIBRAW_Canon_RecordMode_JPEG
    LIBRAW_Canon_RecordMode_CRW_THM
    LIBRAW_Canon_RecordMode_AVI_THM
    LIBRAW_Canon_RecordMode_TIF
    LIBRAW_Canon_RecordMode_TIF_JPEG
    LIBRAW_Canon_RecordMode_CR2
    LIBRAW_Canon_RecordMode_CR2_JPEG
    LIBRAW_Canon_RecordMode_UNKNOWN
    LIBRAW_Canon_RecordMode_MOV
    LIBRAW_Canon_RecordMode_MP4
    LIBRAW_Canon_RecordMode_CRM
    LIBRAW_Canon_RecordMode_CR3
    LIBRAW_Canon_RecordMode_CR3_JPEG
    LIBRAW_Canon_RecordMode_HEIF
    LIBRAW_Canon_RecordMode_CR3_HEIF
    LIBRAW_Canon_RecordMode_TheLastOne
  end

  enum MinoltaStoragemethods
    LIBRAW_MINOLTA_UNPACKED = 0x52
    LIBRAW_MINOLTA_PACKED   = 0x59
  end

  enum MinoltaBayerpatterns
    LIBRAW_MINOLTA_RGGB   = 0x01
    LIBRAW_MINOLTA_G2BRG1 = 0x04
  end

  enum SonyCameratypes
    LIBRAW_SONY_DSC                =      1
    LIBRAW_SONY_DSLR               =      2
    LIBRAW_SONY_NEX                =      3
    LIBRAW_SONY_SLT                =      4
    LIBRAW_SONY_ILCE               =      5
    LIBRAW_SONY_ILCA               =      6
    LIBRAW_SONY_CameraType_UNKNOWN = 0xffff
  end

  enum Sony0x2010Type
    LIBRAW_SONY_Tag2010None = 0
    LIBRAW_SONY_Tag2010a
    LIBRAW_SONY_Tag2010b
    LIBRAW_SONY_Tag2010c
    LIBRAW_SONY_Tag2010d
    LIBRAW_SONY_Tag2010e
    LIBRAW_SONY_Tag2010f
    LIBRAW_SONY_Tag2010g
    LIBRAW_SONY_Tag2010h
    LIBRAW_SONY_Tag2010i
  end

  enum Sony0x9050Type
    LIBRAW_SONY_Tag9050None = 0
    LIBRAW_SONY_Tag9050a
    LIBRAW_SONY_Tag9050b
    LIBRAW_SONY_Tag9050c
  end

  enum SONYFOCUSMODEmodes
    LIBRAW_SONY_FOCUSMODE_MF           =   0
    LIBRAW_SONY_FOCUSMODE_AF_S         =   2
    LIBRAW_SONY_FOCUSMODE_AF_C         =   3
    LIBRAW_SONY_FOCUSMODE_AF_A         =   4
    LIBRAW_SONY_FOCUSMODE_DMF          =   6
    LIBRAW_SONY_FOCUSMODE_AF_D         =   7
    LIBRAW_SONY_FOCUSMODE_AF           = 101
    LIBRAW_SONY_FOCUSMODE_PERMANENT_AF = 104
    LIBRAW_SONY_FOCUSMODE_SEMI_MF      = 105
    LIBRAW_SONY_FOCUSMODE_UNKNOWN      =  -1
  end

  enum KodakSensors
    LIBRAW_Kodak_UnknownSensor =  0
    LIBRAW_Kodak_M1            =  1
    LIBRAW_Kodak_M15           =  2
    LIBRAW_Kodak_M16           =  3
    LIBRAW_Kodak_M17           =  4
    LIBRAW_Kodak_M2            =  5
    LIBRAW_Kodak_M23           =  6
    LIBRAW_Kodak_M24           =  7
    LIBRAW_Kodak_M3            =  8
    LIBRAW_Kodak_M5            =  9
    LIBRAW_Kodak_M6            = 10
    LIBRAW_Kodak_C14           = 11
    LIBRAW_Kodak_X14           = 12
    LIBRAW_Kodak_M11           = 13
  end

  enum HasselbladFormatCodes
    LIBRAW_HF_Unknown                = 0
    LIBRAW_HF_3FR
    LIBRAW_HF_FFF
    LIBRAW_HF_Imacon
    LIBRAW_HF_HasselbladDNG
    LIBRAW_HF_AdobeDNG
    LIBRAW_HF_AdobeDNG_fromPhocusDNG
  end

  enum RawspecialT
    LIBRAW_RAWSPECIAL_SONYARW2_NONE          = 0
    LIBRAW_RAWSPECIAL_SONYARW2_BASEONLY      = 1
    LIBRAW_RAWSPECIAL_SONYARW2_DELTAONLY     = 1 << 1
    LIBRAW_RAWSPECIAL_SONYARW2_DELTAZEROBASE = 1 << 2
    LIBRAW_RAWSPECIAL_SONYARW2_DELTATOVALUE  = 1 << 3
    LIBRAW_RAWSPECIAL_SONYARW2_ALLFLAGS      = LIBRAW_RAWSPECIAL_SONYARW2_BASEONLY +
      LIBRAW_RAWSPECIAL_SONYARW2_DELTAONLY +
      LIBRAW_RAWSPECIAL_SONYARW2_DELTAZEROBASE +
      LIBRAW_RAWSPECIAL_SONYARW2_DELTATOVALUE
    LIBRAW_RAWSPECIAL_NODP2Q_INTERPOLATERG = 1 << 4
    LIBRAW_RAWSPECIAL_NODP2Q_INTERPOLATEAF = 1 << 5
    LIBRAW_RAWSPECIAL_SRAW_NO_RGB          = 1 << 6
    LIBRAW_RAWSPECIAL_SRAW_NO_INTERPOLATE  = 1 << 7
  end

  enum RawspeedBitsT
    LIBRAW_RAWSPEEDV1_USE           = 1
    LIBRAW_RAWSPEEDV1_FAILONUNKNOWN = 1 << 1
    LIBRAW_RAWSPEEDV1_IGNOREERRORS  = 1 << 2
    # /*  bits 3-7 are reserved*/
    LIBRAW_RAWSPEEDV3_USE           = 1 << 8
    LIBRAW_RAWSPEEDV3_FAILONUNKNOWN = 1 << 9
    LIBRAW_RAWSPEEDV3_IGNOREERRORS  = 1 << 10
  end

  enum ProcessingOptions
    LIBRAW_RAWOPTIONS_PENTAX_PS_ALLFRAMES            = 1
    LIBRAW_RAWOPTIONS_CONVERTFLOAT_TO_INT            = 1 << 1
    LIBRAW_RAWOPTIONS_ARQ_SKIP_CHANNEL_SWAP          = 1 << 2
    LIBRAW_RAWOPTIONS_NO_ROTATE_FOR_KODAK_THUMBNAILS = 1 << 3
    #  LIBRAW_RAWOPTIONS_USE_DNG_DEFAULT_CROP = 1 << 4
    LIBRAW_RAWOPTIONS_USE_PPM16_THUMBS                 = 1 << 5
    LIBRAW_RAWOPTIONS_DONT_CHECK_DNG_ILLUMINANT        = 1 << 6
    LIBRAW_RAWOPTIONS_DNGSDK_ZEROCOPY                  = 1 << 7
    LIBRAW_RAWOPTIONS_ZEROFILTERS_FOR_MONOCHROMETIFFS  = 1 << 8
    LIBRAW_RAWOPTIONS_DNG_ADD_ENHANCED                 = 1 << 9
    LIBRAW_RAWOPTIONS_DNG_ADD_PREVIEWS                 = 1 << 10
    LIBRAW_RAWOPTIONS_DNG_PREFER_LARGEST_IMAGE         = 1 << 11
    LIBRAW_RAWOPTIONS_DNG_STAGE2                       = 1 << 12
    LIBRAW_RAWOPTIONS_DNG_STAGE3                       = 1 << 13
    LIBRAW_RAWOPTIONS_DNG_ALLOWSIZECHANGE              = 1 << 14
    LIBRAW_RAWOPTIONS_DNG_DISABLEWBADJUST              = 1 << 15
    LIBRAW_RAWOPTIONS_PROVIDE_NONSTANDARD_WB           = 1 << 16
    LIBRAW_RAWOPTIONS_CAMERAWB_FALLBACK_TO_DAYLIGHT    = 1 << 17
    LIBRAW_RAWOPTIONS_CHECK_THUMBNAILS_KNOWN_VENDORS   = 1 << 18
    LIBRAW_RAWOPTIONS_CHECK_THUMBNAILS_ALL_VENDORS     = 1 << 19
    LIBRAW_RAWOPTIONS_DNG_STAGE2_IFPRESENT             = 1 << 20
    LIBRAW_RAWOPTIONS_DNG_STAGE3_IFPRESENT             = 1 << 21
    LIBRAW_RAWOPTIONS_DNG_ADD_MASKS                    = 1 << 22
    LIBRAW_RAWOPTIONS_CANON_IGNORE_MAKERNOTES_ROTATION = 1 << 23
  end

  enum DecoderFlags
    LIBRAW_DECODER_HASCURVE            = 1 << 4
    LIBRAW_DECODER_SONYARW2            = 1 << 5
    LIBRAW_DECODER_TRYRAWSPEED         = 1 << 6
    LIBRAW_DECODER_OWNALLOC            = 1 << 7
    LIBRAW_DECODER_FIXEDMAXC           = 1 << 8
    LIBRAW_DECODER_ADOBECOPYPIXEL      = 1 << 9
    LIBRAW_DECODER_LEGACY_WITH_MARGINS = 1 << 10
    LIBRAW_DECODER_3CHANNEL            = 1 << 11
    LIBRAW_DECODER_SINAR4SHOT          = 1 << 11
    LIBRAW_DECODER_FLATDATA            = 1 << 12
    LIBRAW_DECODER_FLAT_BG2_SWAPPED    = 1 << 13
    LIBRAW_DECODER_UNSUPPORTED_FORMAT  = 1 << 14
    LIBRAW_DECODER_NOTSET              = 1 << 15
    LIBRAW_DECODER_TRYRAWSPEED3        = 1 << 16
  end

  # define LIBRAW_XTRANS 9

  enum ConstructorFlags
    LIBRAW_OPTIONS_NONE                = 0
    LIBRAW_OPTIONS_NO_DATAERR_CALLBACK = 1 << 1
    # /* Compatibility w/ years old typo */
    LIBRAW_OPIONS_NO_DATAERR_CALLBACK = LIBRAW_OPTIONS_NO_DATAERR_CALLBACK
  end

  enum Warnings
    LIBRAW_WARN_NONE                = 0
    LIBRAW_WARN_BAD_CAMERA_WB       = 1 << 2
    LIBRAW_WARN_NO_METADATA         = 1 << 3
    LIBRAW_WARN_NO_JPEGLIB          = 1 << 4
    LIBRAW_WARN_NO_EMBEDDED_PROFILE = 1 << 5
    LIBRAW_WARN_NO_INPUT_PROFILE    = 1 << 6
    LIBRAW_WARN_BAD_OUTPUT_PROFILE  = 1 << 7
    LIBRAW_WARN_NO_BADPIXELMAP      = 1 << 8
    LIBRAW_WARN_BAD_DARKFRAME_FILE  = 1 << 9
    LIBRAW_WARN_BAD_DARKFRAME_DIM   = 1 << 10
    # ifdef LIBRAW_OLD_VIDEO_SUPPORT
    LIBRAW_WARN_NO_JASPER = 1 << 11
    # endif
    LIBRAW_WARN_RAWSPEED_PROBLEM      = 1 << 12
    LIBRAW_WARN_RAWSPEED_UNSUPPORTED  = 1 << 13
    LIBRAW_WARN_RAWSPEED_PROCESSED    = 1 << 14
    LIBRAW_WARN_FALLBACK_TO_AHD       = 1 << 15
    LIBRAW_WARN_PARSEFUJI_PROCESSED   = 1 << 16
    LIBRAW_WARN_DNGSDK_PROCESSED      = 1 << 17
    LIBRAW_WARN_DNG_IMAGES_REORDERED  = 1 << 18
    LIBRAW_WARN_DNG_STAGE2_APPLIED    = 1 << 19
    LIBRAW_WARN_DNG_STAGE3_APPLIED    = 1 << 20
    LIBRAW_WARN_RAWSPEED3_PROBLEM     = 1 << 21
    LIBRAW_WARN_RAWSPEED3_UNSUPPORTED = 1 << 22
    LIBRAW_WARN_RAWSPEED3_PROCESSED   = 1 << 23
    LIBRAW_WARN_RAWSPEED3_NOTLISTED   = 1 << 24
  end

  enum Exceptions
    LIBRAW_EXCEPTION_NONE                  =  0
    LIBRAW_EXCEPTION_ALLOC                 =  1
    LIBRAW_EXCEPTION_DECODE_RAW            =  2
    LIBRAW_EXCEPTION_DECODE_JPEG           =  3
    LIBRAW_EXCEPTION_IO_EOF                =  4
    LIBRAW_EXCEPTION_IO_CORRUPT            =  5
    LIBRAW_EXCEPTION_CANCELLED_BY_CALLBACK =  6
    LIBRAW_EXCEPTION_BAD_CROP              =  7
    LIBRAW_EXCEPTION_IO_BADFILE            =  8
    LIBRAW_EXCEPTION_DECODE_JPEG2000       =  9
    LIBRAW_EXCEPTION_TOOBIG                = 10
    LIBRAW_EXCEPTION_MEMPOOL               = 11
    LIBRAW_EXCEPTION_UNSUPPORTED_FORMAT    = 12
  end

  enum Progress
    LIBRAW_PROGRESS_START              = 0
    LIBRAW_PROGRESS_OPEN               = 1
    LIBRAW_PROGRESS_IDENTIFY           = 1 << 1
    LIBRAW_PROGRESS_SIZE_ADJUST        = 1 << 2
    LIBRAW_PROGRESS_LOAD_RAW           = 1 << 3
    LIBRAW_PROGRESS_RAW2_IMAGE         = 1 << 4
    LIBRAW_PROGRESS_REMOVE_ZEROES      = 1 << 5
    LIBRAW_PROGRESS_BAD_PIXELS         = 1 << 6
    LIBRAW_PROGRESS_DARK_FRAME         = 1 << 7
    LIBRAW_PROGRESS_FOVEON_INTERPOLATE = 1 << 8
    LIBRAW_PROGRESS_SCALE_COLORS       = 1 << 9
    LIBRAW_PROGRESS_PRE_INTERPOLATE    = 1 << 10
    LIBRAW_PROGRESS_INTERPOLATE        = 1 << 11
    LIBRAW_PROGRESS_MIX_GREEN          = 1 << 12
    LIBRAW_PROGRESS_MEDIAN_FILTER      = 1 << 13
    LIBRAW_PROGRESS_HIGHLIGHTS         = 1 << 14
    LIBRAW_PROGRESS_FUJI_ROTATE        = 1 << 15
    LIBRAW_PROGRESS_FLIP               = 1 << 16
    LIBRAW_PROGRESS_APPLY_PROFILE      = 1 << 17
    LIBRAW_PROGRESS_CONVERT_RGB        = 1 << 18
    LIBRAW_PROGRESS_STRETCH            = 1 << 19
    # /* reserved */
    LIBRAW_PROGRESS_STAGE20 = 1 << 20
    LIBRAW_PROGRESS_STAGE21 = 1 << 21
    LIBRAW_PROGRESS_STAGE22 = 1 << 22
    LIBRAW_PROGRESS_STAGE23 = 1 << 23
    LIBRAW_PROGRESS_STAGE24 = 1 << 24
    LIBRAW_PROGRESS_STAGE25 = 1 << 25
    LIBRAW_PROGRESS_STAGE26 = 1 << 26
    LIBRAW_PROGRESS_STAGE27 = 1 << 27

    LIBRAW_PROGRESS_THUMB_LOAD = 1 << 28
    LIBRAW_PROGRESS_TRESERVED1 = 1 << 29
    LIBRAW_PROGRESS_TRESERVED2 = 1 << 30
  end

  LIBRAW_PROGRESS_THUMB_MASK = 0x0fffffff

  enum Errors
    LIBRAW_SUCCESS                           =       0
    LIBRAW_UNSPECIFIED_ERROR                 =      -1
    LIBRAW_FILE_UNSUPPORTED                  =      -2
    LIBRAW_REQUEST_FOR_NONEXISTENT_IMAGE     =      -3
    LIBRAW_OUT_OF_ORDER_CALL                 =      -4
    LIBRAW_NO_THUMBNAIL                      =      -5
    LIBRAW_UNSUPPORTED_THUMBNAIL             =      -6
    LIBRAW_INPUT_CLOSED                      =      -7
    LIBRAW_NOT_IMPLEMENTED                   =      -8
    LIBRAW_REQUEST_FOR_NONEXISTENT_THUMBNAIL =      -9
    LIBRAW_UNSUFFICIENT_MEMORY               = -100007
    LIBRAW_DATA_ERROR                        = -100008
    LIBRAW_IO_ERROR                          = -100009
    LIBRAW_CANCELLED_BY_CALLBACK             = -100010
    LIBRAW_BAD_CROP                          = -100011
    LIBRAW_TOO_BIG                           = -100012
    LIBRAW_MEMPOOL_OVERFLOW                  = -100013
  end

  enum InternalThumbnailFormats
    LIBRAW_INTERNAL_THUMBNAIL_UNKNOWN     = 0
    LIBRAW_INTERNAL_THUMBNAIL_KODAK_THUMB = 1
    LIBRAW_INTERNAL_THUMBNAIL_KODAK_YCBCR = 2
    LIBRAW_INTERNAL_THUMBNAIL_KODAK_RGB   = 3
    LIBRAW_INTERNAL_THUMBNAIL_JPEG        = 4
    LIBRAW_INTERNAL_THUMBNAIL_LAYER
    LIBRAW_INTERNAL_THUMBNAIL_ROLLEI
    LIBRAW_INTERNAL_THUMBNAIL_PPM
    LIBRAW_INTERNAL_THUMBNAIL_PPM16
    LIBRAW_INTERNAL_THUMBNAIL_X3F
  end

  enum ThumbnailFormats
    LIBRAW_THUMBNAIL_UNKNOWN  = 0
    LIBRAW_THUMBNAIL_JPEG     = 1
    LIBRAW_THUMBNAIL_BITMAP   = 2
    LIBRAW_THUMBNAIL_BITMAP16 = 3
    LIBRAW_THUMBNAIL_LAYER    = 4
    LIBRAW_THUMBNAIL_ROLLEI   = 5
    LIBRAW_THUMBNAIL_H265     = 6
  end

  enum ImageFormats
    LIBRAW_IMAGE_JPEG   = 1
    LIBRAW_IMAGE_BITMAP = 2
  end
end
