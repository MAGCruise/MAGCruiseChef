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
  'recipe[ntp]',
  'recipe[timezone]',
  'recipe[git]',
  'recipe[iptables-setup]',
  'recipe[yum-epel]',
  'recipe[yum-remi]',
  'recipe[yum-repoforge]'
]
