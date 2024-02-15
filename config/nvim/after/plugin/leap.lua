local leap = require("leap")
leap.opts.case_sensitive = true
leap.opts.substitute_chars = { ['\r'] = '¬' }
leap.opts.special_keys =  {
      next_target = '<enter>',
      prev_target = '<tab>',
      next_group = '<space>',
      prev_group = '<tab>',
    }
leap .create_default_mappings()

