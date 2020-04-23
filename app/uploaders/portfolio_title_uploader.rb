class PortfolioTitleUploader < BaseUploader

    #process :resize_to_fit_by_percentage

begin
    create_sizes(
      sizes: {
        "1x" => [1366, 768],
        "2x" => [2732, 1536],
        "3x" => [4098, 2304]
      },
      namespace: "bg"#,
      #only_retina_mode: true
    )
end



    #calculate_retina_sizes_from_source()
=begin
    create_sizes(
      sizes: {
        "1x" => @retina_sizes["1x"],
        "2x" => @retina_sizes["2x"],
        "3x" => @retina_sizes["3x"]
      },
      namespace: "bg"
    )
=end
end
