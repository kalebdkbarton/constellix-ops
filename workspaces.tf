locals {
  #----------------------------------------------------------------------------
  # Workspace Defaults
  #----------------------------------------------------------------------------
  name = "kaleb_test created with terraform"
  # tag defaults
  default_record = {
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
  }
}