locals {
  #----------------------------------------------------------------------------
  # Workspace Defaults
  #----------------------------------------------------------------------------
  note    = "kaleb_test created with terraform"
  domains = ["kalebbarton-test.com"]

  #----------------------------------------------------------------------------
  # Records
  #----------------------------------------------------------------------------

  records = {
    a = {
      www    = "1.2.3.4",
      test   = "4.3.2.1",
      hi     = "10.10.10.10"
      tftest = "3.2.5.1"
    }
    aaaa = {
      www = "5:0:0:0:0:0:1:6"
    }
    cname = {
      resume = "resume.malavear.com"
    }
    aname = {
      root = "www"
    }
    ns = {
      ns = "ns0.dnsmadeeasy.com"
    }
    txt = {
      root = "v=spf1"
    }
    spf = {
      root = "This is depreciated"
    }
    srv = {
      ###### value,port,priority,weight
      _tcp = "www.google.com,8888,65,20"
    }

  }

  #----------------------------------------------------------------------------
  # Pools
  #----------------------------------------------------------------------------
  pools = {
    test_pool1 = {
      values = [
        {
          value        = "108.157.142.75"
          weight       = 20
          policy       = "followsonar"
          disable_flag = false
          fqdn         = "resume.malavear.com"
        },
        {
          value        = "108.157.142.25"
          weight       = 20
          policy       = "followsonar"
          disable_flag = false
          fqdn         = "resume.malavear.com"
        }
      ]
    },
    test_pool2 = {
      values = [
        {
          value        = "108.157.142.97"
          weight       = 20
          policy       = "followsonar"
          disable_flag = false
          fqdn         = "resume.malavear.com"
        },
        {
          value        = "108.157.142.56"
          weight       = 30
          policy       = "followsonar"
          disable_flag = false
          fqdn         = "resume.malavear.com"
        }
      ]
    },
    test_pool3 = {
      values = [
        {
          value        = "108.157.142.25"
          weight       = 20
          policy       = "followsonar"
          disable_flag = false
          fqdn         = "resume.malavear.com"
        },
        {
          value        = "108.157.142.56"
          weight       = 30
          policy       = "followsonar"
          disable_flag = false
          fqdn         = "resume.malavear.com"
        }
      ]
    }
  }
}