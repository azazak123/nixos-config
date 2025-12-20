{
  enable = true;
  defaultEditor = true;
  settings = {
    theme = "material_palenight";
    editor = {
    line-number = "relative";
      cursor-shape = {
        normal = "block";      
        insert = "bar";        
        select = "underline";  
      };
    };
    keys = {
      normal = {
        up = "no_op";
        down = "no_op";
        left = "no_op";
        right = "no_op";
        
        pageup = "no_op";
        pagedown = "no_op";
      };

      select = {
        up = "no_op";
        down = "no_op";
        left = "no_op";
        right = "no_op";
      };

      insert = {
        up = "no_op";
        down = "no_op";
        left = "no_op";
        right = "no_op";
      };
    };
  };
}
