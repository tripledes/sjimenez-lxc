#
class lxc::sources::precise {
  contain 'apt'

  apt::ppa { 'lxc':
    ensure  => present,
    name    => 'ppa:ubuntu-lxc/stable',
    release => 'precise',
    tag     => 'lxc',
  }

  Apt::Ppa <| tag == 'lxc' |> -> Package <| tag == 'lxc_packages' |>
}
