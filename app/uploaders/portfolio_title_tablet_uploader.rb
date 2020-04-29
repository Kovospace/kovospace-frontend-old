## titulny obrazok na stranke o jednotlivom projekte

class PortfolioTitleTabletUploader < BaseUploader

    ## velkost s vynechana
    create_sizes(
      sizes: {
        "xl_1x" => [480, 10000],
        "xl_2x" => [960, 10000],
        "xl_3x" => [1440, 10000],
        "l_1x" => [360, 10000],
        "l_2x" => [720, 10000],
        "l_3x" => [1080, 10000],
        "m_1x" => [216, 10000],
        "m_2x" => [432, 10000],
        "m_3x" => [638, 10000],
        "xs_1x" => [144, 10000],
        "xs_2x" => [288, 10000]
      },
      namespace: "title_bg_tablet"
    )

end
