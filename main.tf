# Configure the Cloudflare provider
provider "cloudflare" {
  email = "${var.cloudflare_email}"
  token = "${var.cloudflare_token}"
}

# IPs
resource "cloudflare_record" "A" {
  domain  = "${var.domain}"
  name    = "${var.domain}"
  value   = "${var.vps_ip}"
  type    = "A"
  proxied = true
}

resource "cloudflare_record" "AAAA" {
  domain  = "${var.domain}"
  name    = "${var.domain}"
  value   = "${var.vps_ipv6}"
  type    = "AAAA"
  proxied = true
}

# CNAME www
resource "cloudflare_record" "WWW" {
  domain  = "${var.domain}"
  name    = "www"
  value   = "${var.domain}"
  type    = "CNAME"
  proxied = true
}

# MX
resource "cloudflare_record" "MX" {
  domain  = "${var.domain}"
  name    = "@"
  value   = "${var.domain}"
  type    = "MX"
  priority = 0
}

# AWS
resource "cloudflare_record" "AWS" {
  domain  = "${var.domain}"
  name    = "_amazonses"
  value   = "${var.aws_ses}"
  type    = "TXT"
}

# SPF1
resource "cloudflare_record" "SPF" {
  domain  = "${var.domain}"
  name    = "@"
  value   = "v=spf1 include:amazonses.com ip4:${var.vps_ip} ip6:${var.vps_ipv6} ~all"
  type    = "TXT"
}

# DKIM AWS SES
resource "cloudflare_record" "DKIM_SES_ONE" {
  domain  = "${var.domain}"
  name    = "ewbpfzwtbpxjwrkonq22rtc76gahaxg5._domainkey.freebooting.me"
  value   = "ewbpfzwtbpxjwrkonq22rtc76gahaxg5.dkim.amazonses.com"
  type    = "CNAME"
}

resource "cloudflare_record" "DKIM_SES_TWO" {
  domain  = "${var.domain}"
  name    = "xqhdyxiyslfu4nqtxf37gormrhplqe4x._domainkey.freebooting.me"
  value   = "xqhdyxiyslfu4nqtxf37gormrhplqe4x.dkim.amazonses.com"
  type    = "CNAME"
}

resource "cloudflare_record" "DKIM_SES_THREE" {
  domain  = "${var.domain}"
  name    = "rloc4fplgx3ykgdsdv5ao3detx3325nz._domainkey.freebooting.me"
  value   = "rloc4fplgx3ykgdsdv5ao3detx3325nz.dkim.amazonses.com"
  type    = "CNAME"
}