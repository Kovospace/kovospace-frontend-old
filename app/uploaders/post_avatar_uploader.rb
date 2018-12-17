class PostAvatarUploader < BaseUploader

  create_sizes(
      sizes: {
        120 => [120, 75],
        160 => [160, 100],
        240 => [240, 150],
        288 => [288, 180],
        320 => [320, 200],
        360 => [360, 225],
        480 => [480, 300],
        533 => [533, 332],
        640 => [640, 400],
        720 => [720, 450],
        768 => [768, 480],
        800 => [800, 500],
        960 => [960, 600],
        1024 => [1024, 640],
        1080 => [1080, 675],
        1125 => [1125, 702],
        1242 => [1242, 776],
        1440 => [1440, 900],
        1536 => [1536, 960],
        2048 => [2048, 1280],
        1668 => [1668, 1042]
      },
      namespace: "title"
  )

  #version :thumb_288p do
    # process resize_to_fill: [288, 216]
  #end

  #version :thumb_160p do
     #process resize_to_fill: [160, 120]
  #end

  def filename
     "bg.jpg" #if original_filename
  end
end
