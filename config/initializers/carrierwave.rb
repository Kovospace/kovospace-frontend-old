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
              c.quality "80"
              c.depth "8"
              c.interlace "plane"
          end
          img
      end
    end

  end



end
