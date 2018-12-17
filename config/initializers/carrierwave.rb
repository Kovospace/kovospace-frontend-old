module CarrierWave

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
            img.gaussian_blur(radius.to_s)
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

    end

end
