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
      www = ["1.2.3.4"]
    }
    aaaa = {
      www = ["5:0:0:0:0:0:1:6"]
    }
    aname = {
      root = ["google.com."]
    }
    cname = {
      resume = ["resume.malavear.com"] #only put 1 value in this
    }
    hinfo = {
      ###### cpu,os
      _tcp = ["quad core,linux2"]
    }
    httpredirection = {
      red = ["https://www.google.com"] #only put 1 value in this
    }
    mx = {
      ###### level,value
      root = ["10,mail.example.com"]
    }
    naptr = {
      ###### order,preference,flags,service,regular_expression,replacement
      root = ["10,100,s,SIP+D2U,hello,foobar.example.com."]
    }
    caa = {
      # 1 for [ Custom ], 2 for [ No Provider ], 3 for Comodo, 4 for Digicert, 5 for Entrust, 6 for GeoTrust, 7 for Izenpe, 8 for Lets Encrypt, 9 for Symantec, 10 for Thawte
      ###### caa_provider_id,tag,data,flag
      root = ["3,issue,como.com,0"]
    }
    cert = {
      ###### certificate_type,key_tag,certificate,algorithm
      root = ["20,30,certificate1,100"]
    }
    ptr = {
      root = ["10"]
    }
    rp = {
      ###### mailbox,txt
      root = ["one.com,domain.com"]
    }
    spf = {
      root = ["This is depreciated"]
    }
    srv = {
      ###### value,port,priority,weight
      _tcp = ["www.google.com,8888,65,20"]
    }
    txt = {
      root = ["v=spf1"]
    }
    ns = {
      ns = ["ns0.dnsmadeeasy.com."]
    }
  }

  #----------------------------------------------------------------------------
  # Pools
  #----------------------------------------------------------------------------
  pools = {
    a = {
      test_a_pool1 = {
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
      }
    }
    cname = {
      test_cname_pool1 = {
        values = [
          {
            value        = "resume.malavear.com"
            weight       = 20
            policy       = "followsonar"
            disable_flag = false
            fqdn         = "resume.malavear.com"
          },
          {
            value        = "malavear.com"
            weight       = 20
            policy       = "followsonar"
            disable_flag = false
            fqdn         = "resume.malavear.com"
          }
        ]
      }
    }
    aaaa = {
      test_aaaa_pool1 = {
        values = [
          # {
          #   value        = "2600:9000:20e9:c000:19:5f0c:4440:93a1"
          #   weight       = 20
          #   policy       = "followsonar"
          #   disable_flag = false
          #   fqdn         = "resume.malavear.com"
          # },
          # {
          #   value        = "2600:9000:20e9:8800:19:5f0c:4440:93a1"
          #   weight       = 20
          #   policy       = "followsonar"
          #   disable_flag = false
          #   fqdn         = "resume.malavear.com"
          # }
        ]
      }
    }
  }
}