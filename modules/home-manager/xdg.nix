{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";

      "image/png" = "vimiv.desktop";
      "image/jpeg" = "vimiv.desktop";
      "image/webp" = "vimiv.desktop";
      "image/gif" = "vimiv.desktop";
      "image/svg+xml" = "vimiv.desktop";

      "application/pdf" = "org.pwmt.zathura-pdf-mupdf.desktop";

      "text/plain" = "nvim.desktop";
      "text/markdown" = "nvim.desktop";
    };
  };
}
