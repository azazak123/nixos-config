{ ... }:

{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      editor = {
        line-number = "relative";
        cursor-shape = {
          normal = "block";      
          insert = "bar";        
          select = "underline";  
        };
        whitespace.render.newline = "all";
      };
    };
  };
}
