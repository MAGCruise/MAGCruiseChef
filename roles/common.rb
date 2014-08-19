name 'common'
description ''
default_attributes(
  ntp: {
    servers: [
      'ntp.jst.mfeed.ad.jp',
      'ntp.nict.jp',
      'ntp.ring.gr.jp'
    ]
  },
  tz: 'Asia/Tokyo'
)
run_list [
  'recipe[apt]',
  'recipe[ntp]',
  'recipe[timezone]',
  'recipe[git]',
  'recipe[magcruise::hosts]'
]
