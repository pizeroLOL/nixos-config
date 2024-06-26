{
  programs.starship = {
    enable = true;
    # 自定义配置
    settings = {
      add_newline = true;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };
}
