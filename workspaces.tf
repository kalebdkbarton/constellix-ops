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
  }

  pools = [
    {
      name = "test_pool1"
      values = [
        {
          value        = "8.1.1.1"
          weight       = 20
          policy       = "alwayson"
          disable_flag = false
        },
        {
          value        = "9.1.1.1"
          weight       = 20
          policy       = "alwayson"
          disable_flag = false
        }
      ]
    },
    {
      name = "test_pool2"
      values = [
        {
          value        = "10.1.1.1"
          weight       = 20
          policy       = "alwayson"
          disable_flag = false
        },
        {
          value        = "11.1.1.1"
          weight       = 30
          policy       = "alwayson"
          disable_flag = false
        }
      ]
    }
  ]

}