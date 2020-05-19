module CarrierWave

=begin
    module RMagick

        def quality(percentage)
          manipulate! do |img|
            img.write(current_path){ self.quality = percentage } unless img.quality == percentage
            img = yield(img) if block_given?
            img
          end
        end

        def exif_rotation
          manipulate! do |img|
            img.auto_orient!
            img = yield(img) if block_given?
            img
          end
        end

        # Strips out all embedded information from the image
        def strip
          manipulate! do |img|
            img.strip!
            img = yield(img) if block_given?
            img
          end
        end

        # Tiny gaussian blur to optimize the size
        def gaussian_blur(radius)
          manipulate! do |img|
            img.gaussian_blur(radius.to_f)
            img = yield(img) if block_given?
            img
          end
        end

        # set the Interlace of the image plane/basic
        def interlace
          manipulate! do |img|
            img.interlace = Magick::PlaneInterlace
            img = yield(img) if block_given?
            img
          end
        end

        def base_stuff
          manipulate! do |img|
            img.auto_orient!
            img.strip!
            #img.gaussian_blur(0.05)
            #img.interlace = Magick::PlaneInterlace
            img.write(current_path) { self.interlace = Magick::PlaneInterlace }
            #img = yield(img) if block_given?
            Rails.logger.info "--------------------"
            Rails.logger.info img.interlace
            img
          end
        end

        def optimizer
          manipulate! do |img|
              return img unless img.mime_type.match /image\/jpeg/
              img.strip
              img.combine_options do |c|
                  c.quality "80"
                  c.depth "8"
                  c.interlace "plane"
              end
              img
          end
        end

    end
=end

  module MiniMagick

    def optimizer
      manipulate! do |img|
          #return img unless img.mime_type.match /image\/jpeg/
          img.format "jpeg"
          img.strip
          img.combine_options do |c|
              #c.resize_to_fit(250,250)
              c.quality "80"
              c.depth "8"
              c.interlace "plane"
          end
          img
      end
    end

    def conversion(*limit)
      manipulate! do |img|
        # Convert to PNG
        img.format("jpeg") do |i|
          i.strip
          # same as MiniMagick#resize_to_limit
          i.resize "#{limit[0]}x#{limit[1]}>" unless limit.empty?
          i.combine_options do |c|
              #c.resize_to_fit(250,250)
              c.quality "80"
              c.depth "8"
              c.interlace "plane"
          end
        end

        img
      end
    end

    def retina_resize
      manipulate! do |img|

          #return img unless img.mime_type.match /image\/jpeg/
          #img.format "jpeg"
          #img.strip
          #img.combine_options do |c|
              #c.resize_to_fit(250,250)
              #c.quality "80"
              #c.depth "8"
              #c.interlace "plane"
          #end
          #img
      end
    end

  end

=begin
  module Uploader
    module Download
      class RemoteFile
        def original_filename
          value = File.basename(file.base_uri.path)
          mime_type = Mime::Type.lookup(file.content_type)
          unless File.extname(value).present? || mime_type.blank?
            value = "#{value}.#{mime_type.symbol}"
          end
          value
        end
      end
    end
  end
=end


end
