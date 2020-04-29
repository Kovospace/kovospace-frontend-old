## titulny obrazok na stranke o jednotlivom projekte

class PortfolioTitleMobileUploader < BaseUploader

    create_sizes(
      sizes: {
        "xl_1x" => [240, 10000],
        "xl_2x" => [480, 10000],
        "xl_3x" => [720, 10000],
        "l_1x" => [188, 10000],
        "l_2x" => [376, 10000],
        "l_3x" => [564, 10000],
        "m_1x" => [112, 10000],
        "m_2x" => [224, 10000],
        "m_3x" => [336, 10000],
        "xs_1x" => [74, 10000],
        "xs_2x" => [148, 10000]
      },
      namespace: "title_bg_mobile"
    )

end
