{ vimUtils, fetchFromGitHub, python3, update-nix-fetchgit }:
let
  inherit (vimUtils) buildVimPluginFrom2Nix;

  coc-source = fetchFromGitHub {
    owner = "neoclide";
    repo = "coc-sources";
    rev = "67f8539df3745af9c67d6c71c4e9b446498336be";
    sha256 = "19hyw6zhhj91rr31dsayi0vhyzwyiv1l033mkbchsbdwgkl53h5p";
  };

in {
  updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";

  mundo = buildVimPluginFrom2Nix {
    name = "vim-mundo";
    src = fetchFromGitHub {
      owner = "simnalamburt";
      repo = "vim-mundo";
      rev = "e193f185bad3aa58446e771f8f2739abf11d3262";
      sha256 = "1q2j88rcg0slvm2bfdri4fy42h5a2md9bbqsspb3kzx5yrhgawhp";
    };
  };

  ncm2-yoink = buildVimPluginFrom2Nix {
    name = "ncm2-yoink";
    src = fetchFromGitHub {
      owner = "svermeulen";
      repo = "ncm2-yoink";
      rev = "802070a996527c4ee227287fc2cdf1f5a8f5d4f2";
      sha256 = "10lzw3xmxcjk9iwii0xbik8y4cmd0bl3r7kc3xcdvs4mzqpnbypa";
    };
  };

  ncm2-syntax = buildVimPluginFrom2Nix {
    name = "ncm2-yoink";
    src = fetchFromGitHub {
      owner = "ncm2";
      repo = "ncm2-syntax";
      rev = "d41d60b22175822c14f497378a05398e3eca2517";
      sha256 = "065sflxr6sp491ifvcf7bzvpn5c47qc0mr091v2p2k73lp9jx2s2";
    };
  };

  neovim-gdb = buildVimPluginFrom2Nix {
    name = "neovim-gdb";
    src = fetchFromGitHub {
      owner = "sakhnik";
      repo = "nvim-gdb";
      rev = "c2a0d076383b8a0991681c33efe80bcba6dd3608";
      sha256 = "19yc51bhfaw53rc9awdr145i8k2i2gnnl3faw85afsqs9dr4hi7i";
    };
    buildInputs = [ python3 ];
    postUnpack = ''
      patchShebangs .
    '';
  };

  vim-smoothie = buildVimPluginFrom2Nix {
    name = "vim-smoothie";
    src = fetchFromGitHub {
      owner = "psliwka";
      repo = "vim-smoothie";
      rev = "10fd0aa57d176718bc2c570f121ab523c4429a25";
      sha256 = "18zn29mkgdiddn3il393xzg7hpa0x25yvais1l29jq2711sg4rdc";
    };
  };

  vim-vala = buildVimPluginFrom2Nix {
    name = "vim-vala";
    src = fetchFromGitHub {
      owner = "arrufat";
      repo = "vala.vim";
      rev = "ce569e187bf8f9b506692ef08c10b584595f8e2d";
      sha256 = "143aq0vxa465jrwajs9psk920bm6spn9ga24f5qdai926hhp2gyl";
    };
  };

  vim-ingo-library = buildVimPluginFrom2Nix {
    name = "vim-ingo-library";
    src = fetchFromGitHub {
      owner = "inkarkat";
      repo = "vim-ingo-library";
      rev = "7a98f551461562a1b8f8a8ab3fdf66940d306613";
      sha256 = "1dqwby8m0m5iwcjf5fi9xdsg10jql7kgqk9p7p65l2wi3fzk96hd";
    };
  };

  context = buildVimPluginFrom2Nix {
    name = "vim-context";
    src = fetchFromGitHub {
      owner = "wellle";
      repo = "context.vim";
      rev = "e38496f1eb5bb52b1022e5c1f694e9be61c3714c";
      sha256 = "1iy614py9qz4rwk9p4pr1ci0m1lvxil0xiv3ymqzhqrw5l55n346";
    };
  };

  gina = buildVimPluginFrom2Nix {
    name = "gina.vim";
    src = fetchFromGitHub {
      owner = "lambdalisue";
      repo = "gina.vim";
      rev = "abdbe0fe33f3b6fc59e94f7cc3072768f8dfd8ac";
      sha256 = "1f3shh6jxr5i1an2dbb1vmc0l2xg03fm6ava25ahxg4b5ka59bc5";
    };
  };

  codi = buildVimPluginFrom2Nix {
    name = "codi.vim";
    src = fetchFromGitHub {
      owner = "metakirby5";
      repo = "codi.vim";
      rev = "cf62681a4962ce1873e4b2a5e0bf401dcd42890f";
      sha256 = "15j08qa7sklm0pilfn3ljgq75hrv8y9h8xzj8ibrafp29640gkfl";
    };
  };

  coc-dictionary = buildVimPluginFrom2Nix {
    name = "coc-dictionary";
    src = coc-source;
    preInstall = ''
      cd packages/dictionary
    '';
  };

  coc-word = buildVimPluginFrom2Nix {
    name = "coc-word";
    src = coc-source;
    preInstall = ''
      cd packages/word
    '';
  };

  coc-syntax = buildVimPluginFrom2Nix {
    name = "coc-syntax";
    src = coc-source;
    preInstall = ''
      cd packages/syntax
    '';
  };

  nerdtree-syntax-highlight = buildVimPluginFrom2Nix {
    name = "vim-nerdtree-syntax-highlight";
    src = fetchFromGitHub {
      owner = "tiagofumo";
      repo = "vim-nerdtree-syntax-highlight";
      rev = "5178ee4d7f4e7761187df30bb709f703d91df18a";
      sha256 = "0i690a9sd3a9193mdm150q5yx43mihpzkm0k5glllsmnwpngrq1a";
    };
  };

  nvim-lsp = buildVimPluginFrom2Nix {
    name = "nvim-lsp";
    src = fetchFromGitHub {
      owner = "neovim";
      repo = "nvim-lsp";
      rev = "f84f592816a6b0c55e2a655b56c480683ad92c63";
      sha256 = "0933hn71qxbcn3g6g7jwhnmn9mywwfl9alnpwa9v5qwch0ardgnh";
    };
  };

  keysound = buildVimPluginFrom2Nix {
    name = "vim-keysound";
    src = fetchFromGitHub {
      owner = "skywind3000";
      repo = "vim-keysound";
      rev = "88a60a3c3537b6342ec221415e2348ae03f8b71d";
      sha256 = "0yjyji5vrha7i15yvs7qf9dmyrilaqkypcmf1a3vhvpcidmb1ha0";
    };
  };

  vidir = buildVimPluginFrom2Nix {
    name = "vidir";
    src = fetchFromGitHub {
      owner = "aca";
      repo = "vidir.nvim";
      rev = "7d1716efca9fd7eae8fc151e32468352ad2ef0bd";
      sha256 = "0klqyp6ky1i3hl0gxda2x8pqsbzf7zq6cwlzkyqys29qnqxisi6g";
    };
  };

  vibusen = buildVimPluginFrom2Nix {
    name = "vibusen.vim";
    src = fetchFromGitHub {
      owner = "lsrdg";
      repo = "vibusen.vim";
      rev = "9d944ea023253d35351e672eb2742ddcf1445355";
      sha256 = "1n2s8b7kya8dnn1d5b0dc8yadl92iwf58s7sb5950b6yyi3i3q7f";
    };
  };

  soong = buildVimPluginFrom2Nix {
    name = "soong.vim";
    src = fetchFromGitHub {
      owner = "cherrry";
      repo = "soong.vim";
      rev = "58f8a2b2e066f76f932b9683883689797b0d7274";
      sha256 = "1mllzgp66ds79anpz1k6gz4dkp2hjhn79iwi8chsap1hrpjc4yp1";
    };
  };
}
