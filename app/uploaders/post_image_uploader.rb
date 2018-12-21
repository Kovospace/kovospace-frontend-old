class PostImageUploader < BaseUploader

  create_sizes(
      sizes: {
        "320w" => [320, 200],
        "360w" => [360, 225],
        "480w" => [480, 300]
      },
      namespace: "photo"
  )

end
