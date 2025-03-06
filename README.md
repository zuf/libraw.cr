# libraw bindings to crystal

[Libraw](https://www.libraw.org/) allow you to load, parse and process virtyally any raw photo.

## Status of this project

Almost all functions and types has low level bindings (LibRawC) from original libraw with thin wrapper via LibRaw class.
But there are no higher layer wrapper yet (TBD).

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     librawcr:
       github: zuf/libraw.cr
   ```

2. Run `shards install`

## Usage

```crystal
require "libraw"

raw_photo_file = "/path/to/photo.cr2"

libraw = LibRaw.new(raw_photo_file)
puts "#{String.new libraw.iparams.make.to_unsafe} #{String.new libraw.iparams.model.to_unsafe} #{String.new libraw.lensinfo.lens.to_unsafe}  | #{libraw.raw_height} x #{libraw.raw_width} ISO=#{libraw.imgother.iso_speed} S=#{libraw.imgother.shutter} A=#{libraw.imgother.aperture} T=#{Time.unix libraw.imgother.timestamp} N=#{libraw.imgother.shot_order}"

# Extract thumbnail from raw and save as separate file
libraw.unpack_thumb
puts "Thumbnail info: #{libraw.thumbnail.tformat} #{libraw.thumbnail.twidth} x #{libraw.thumbnail.theight} colors: #{libraw.thumbnail.tcolors} #{libraw.thumbnail.tlength.humanize_bytes}"

# Assume thumbnail in jpeg format (most common case).
# See also https://www.libraw.org/docs/API-datastruct-eng.html#LibRaw_thumbnail_formats
File.write "/tmp/photo_thumbnail.jpg", libraw.tumbnail_bytes

# unpack raw data
libraw.unpack
libraw.dcraw_process

# Save as uncompressed rgb data
libraw.dcraw_ppm_tiff_writer "/tmp/photo.ppm"
```

## Licensing

As the original LibRaw library this bindings is distributed free of charge and with open-source code subject to two licenses:

1. GNU LESSER GENERAL PUBLIC LICENSE version 2.1

2. COMMON DEVELOPMENT AND DISTRIBUTION LICENSE (CDDL) Version 1.0