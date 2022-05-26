{ vimUtils, fetchFromGitHub, python3, update-nix-fetchgit }:
let
  inherit (vimUtils) buildVimPluginFrom2Nix;

  coc-source = fetchFromGitHub {
    owner = "neoclide";
    repo = "coc-sources";
    rev = "70564820ac1718b7f85f6cd9e67269500bd41211";
    sha256 = "1l7lhys5vmb0ixnxrhis10yh68icq4a13qmpx0yy14kal9aiqg20";
  };

in {
  updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";

  mundo = buildVimPluginFrom2Nix {
    name = "vim-mundo";
    src = fetchFromGitHub {
      owner = "simnalamburt";
      repo = "vim-mundo";
      rev = "595ee332719f397c2441d85f79608113957cc78f";
      sha256 = "0kwiw877izpjqfj4gp4km8ivj6iy2c2jxyiqgxrvjqna62kic0ap";
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
      rev = "9c630705829fbe8c21a9379ae2be948560189d80";
      sha256 = "1cdc2r12k1nma37vicshy4kbk79ap8qj040rscxzl41z96ff8v0b";
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
      rev = "5b8a6746f3053ecd4e05d3de0739682e9f3e178f";
      sha256 = "1rczaw1zmiq2ncf7ann51znsqx3glyrx721qrq7pmxxjzz9fq900";
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
      rev = "8ed1eea47cdc8508a57713a4a791ab958b05d727";
      sha256 = "105pkk0imfapm213n3qqmxqk17d7jpfylfb8bwic1wncq6vzv215";
    };
  };

  context = buildVimPluginFrom2Nix {
    name = "vim-context";
    src = fetchFromGitHub {
      owner = "wellle";
      repo = "context.vim";
      rev = "c06541451aa94957c1c07a9f8a7130ad97d83a65";
      sha256 = "1n9623cp8ljyrwnq0i4zqfaxp1fwsl5l3shg87ksn1xvj14fw66c";
    };
  };

  gina = buildVimPluginFrom2Nix {
    name = "gina.vim";
    src = fetchFromGitHub {
      owner = "lambdalisue";
      repo = "gina.vim";
      rev = "ff6c2ddeca98f886b57fb42283c12e167d6ab575";
      sha256 = "09jlnpix2dy6kggiz96mrm5l1f9x1gl5afpdmfrxgkighn2rwpzq";
    };
  };

  codi = buildVimPluginFrom2Nix {
    name = "codi.vim";
    src = fetchFromGitHub {
      owner = "metakirby5";
      repo = "codi.vim";
      rev = "c120785c950f9991d32d3d4d2f3696fa8a8b5582";
      sha256 = "0fq01fh717fkq1qlr4ykn7b97l8775c8ja6q3gqs368nf6l94a4i";
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
      rev = "b86a37caf7a4e53e62ba883aef5889b590260de9";
      sha256 = "0bp1wqiwngrcl4isnnk12v3kzzrvjfbwhx79jvfzqnlqnl9q4m1p";
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
      rev = "0ebc07147c4a6d2cd143b8c8bf193d4c6a6d248e";
      sha256 = "1wbib0vcr5qaj6dbsk8gd2ak3ams5af5dhsdac6m7q45wf842p6z";
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
