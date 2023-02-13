{ vimUtils, fetchFromGitHub, python3, update-nix-fetchgit }:
let
  inherit (vimUtils) buildVimPluginFrom2Nix;

  coc-source = fetchFromGitHub {
    owner = "neoclide";
    repo = "coc-sources";
    rev = "a6e5e3bc1f1ae6a52c721f8e5b4e3fd7f59b46c1";
    sha256 = "18pwama01ka6nf16amckaxba3sy11y2j5ws6fk7692wmvg2id4bw";
  };

in {
  updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";

  mundo = buildVimPluginFrom2Nix {
    pname = "vim-mundo";
    version = "unstable-2022-11-05";
    src = fetchFromGitHub {
      owner = "simnalamburt";
      repo = "vim-mundo";
      rev = "b53d35fb5ca9923302b9ef29e618ab2db4cc675e";
      sha256 = "1dwrarcxrh8in78igm036lpvyww60c93vmmlk8h054i3v2p8vv59";
    };
  };

  ncm2-yoink = buildVimPluginFrom2Nix {
    pname = "ncm2-yoink";
    version = "unstable-2019-03-29";
    src = fetchFromGitHub {
      owner = "svermeulen";
      repo = "ncm2-yoink";
      rev = "802070a996527c4ee227287fc2cdf1f5a8f5d4f2";
      sha256 = "10lzw3xmxcjk9iwii0xbik8y4cmd0bl3r7kc3xcdvs4mzqpnbypa";
    };
  };

  ncm2-syntax = buildVimPluginFrom2Nix {
    pname = "ncm2-yoink";
    version = "unstable-2020-07-19";
    src = fetchFromGitHub {
      owner = "ncm2";
      repo = "ncm2-syntax";
      rev = "d41d60b22175822c14f497378a05398e3eca2517";
      sha256 = "065sflxr6sp491ifvcf7bzvpn5c47qc0mr091v2p2k73lp9jx2s2";
    };
  };

  neovim-gdb = buildVimPluginFrom2Nix {
    pname = "neovim-gdb";
    version = "unstable-2022-11-29";
    src = fetchFromGitHub {
      owner = "sakhnik";
      repo = "nvim-gdb";
      rev = "9a6adc688bf9acf1628b014d2c7217443dd6fa6f";
      sha256 = "17rkx4bwr392minrp2db6s4rq3j4sz53mhcq8caz9cfmny2c3idr";
    };
    buildInputs = [ python3 ];
    postUnpack = ''
      patchShebangs .
    '';
  };

  vim-smoothie = buildVimPluginFrom2Nix {
    pname = "vim-smoothie";
    version = "unstable-2022-06-10";
    src = fetchFromGitHub {
      owner = "psliwka";
      repo = "vim-smoothie";
      rev = "df1e324e9f3395c630c1c523d0555a01d2eb1b7e";
      sha256 = "1c87zc954wk76h9klxyygv19jp729fms2f5m18gwzskars3px076";
    };
  };

  vim-vala = buildVimPluginFrom2Nix {
    pname = "vim-vala";
    version = "unstable-2020-05-03";
    src = fetchFromGitHub {
      owner = "arrufat";
      repo = "vala.vim";
      rev = "ce569e187bf8f9b506692ef08c10b584595f8e2d";
      sha256 = "143aq0vxa465jrwajs9psk920bm6spn9ga24f5qdai926hhp2gyl";
    };
  };

  vim-ingo-library = buildVimPluginFrom2Nix {
    pname = "vim-ingo-library";
    version = "unstable-2022-12-30";
    src = fetchFromGitHub {
      owner = "inkarkat";
      repo = "vim-ingo-library";
      rev = "097b1c729ee0f334a40eddfbd84d77161287f2f1";
      sha256 = "07pph8jgv8hx0mbv57k66ps2w6lcmxwwwwdrin7xf0228myxh9fh";
    };
  };

  context = buildVimPluginFrom2Nix {
    pname = "vim-context";
    version = "unstable-2022-05-02";
    src = fetchFromGitHub {
      owner = "wellle";
      repo = "context.vim";
      rev = "c06541451aa94957c1c07a9f8a7130ad97d83a65";
      sha256 = "1n9623cp8ljyrwnq0i4zqfaxp1fwsl5l3shg87ksn1xvj14fw66c";
    };
  };

  gina = buildVimPluginFrom2Nix {
    pname = "gina.vim";
    version = "unstable-2022-03-30";
    src = fetchFromGitHub {
      owner = "lambdalisue";
      repo = "gina.vim";
      rev = "ff6c2ddeca98f886b57fb42283c12e167d6ab575";
      sha256 = "09jlnpix2dy6kggiz96mrm5l1f9x1gl5afpdmfrxgkighn2rwpzq";
    };
  };

  codi = buildVimPluginFrom2Nix {
    pname = "codi.vim";
    version = "unstable-2023-01-24";
    src = fetchFromGitHub {
      owner = "metakirby5";
      repo = "codi.vim";
      rev = "ab8c5faa867424c79a7d5d3a7f55d3a2528ee9b9";
      sha256 = "0d3rpj31wd5xzwcrnv7rwm54g81s3i4hxs7lcwph8k1j7pb8i1nl";
    };
  };

  coc-dictionary = buildVimPluginFrom2Nix {
    pname = "coc-dictionary";
    version = "git";
    src = coc-source;
    preInstall = ''
      cd packages/dictionary
    '';
  };

  coc-word = buildVimPluginFrom2Nix {
    pname = "coc-word";
    version = "git";
    src = coc-source;
    preInstall = ''
      cd packages/word
    '';
  };

  coc-syntax = buildVimPluginFrom2Nix {
    pname = "coc-syntax";
    version = "git";
    src = coc-source;
    preInstall = ''
      cd packages/syntax
    '';
  };

  nerdtree-syntax-highlight = buildVimPluginFrom2Nix {
    pname = "vim-nerdtree-syntax-highlight";
    version = "unstable-2021-01-11";
    src = fetchFromGitHub {
      owner = "tiagofumo";
      repo = "vim-nerdtree-syntax-highlight";
      rev = "5178ee4d7f4e7761187df30bb709f703d91df18a";
      sha256 = "0i690a9sd3a9193mdm150q5yx43mihpzkm0k5glllsmnwpngrq1a";
    };
  };

  nvim-lsp = buildVimPluginFrom2Nix {
    pname = "nvim-lsp";
    version = "unstable-2023-02-12";
    src = fetchFromGitHub {
      owner = "neovim";
      repo = "nvim-lsp";
      rev = "1712672e4da3003a0dd9f771d30389600b360f42";
      sha256 = "18dpijknw3w82rag39acw60vwc6q0apc8hm82x6103gqsimcs3as";
    };
  };

  keysound = buildVimPluginFrom2Nix {
    pname = "vim-keysound";
    version = "unstable-2019-01-15";
    src = fetchFromGitHub {
      owner = "skywind3000";
      repo = "vim-keysound";
      rev = "88a60a3c3537b6342ec221415e2348ae03f8b71d";
      sha256 = "0yjyji5vrha7i15yvs7qf9dmyrilaqkypcmf1a3vhvpcidmb1ha0";
    };
  };

  vidir = buildVimPluginFrom2Nix {
    pname = "vidir";
    version = "unstable-2022-01-10";
    src = fetchFromGitHub {
      owner = "aca";
      repo = "vidir.nvim";
      rev = "0ebc07147c4a6d2cd143b8c8bf193d4c6a6d248e";
      sha256 = "1wbib0vcr5qaj6dbsk8gd2ak3ams5af5dhsdac6m7q45wf842p6z";
    };
  };

  vibusen = buildVimPluginFrom2Nix {
    pname = "vibusen.vim";
    version = "unstable-2020-04-01";
    src = fetchFromGitHub {
      owner = "lsrdg";
      repo = "vibusen.vim";
      rev = "9d944ea023253d35351e672eb2742ddcf1445355";
      sha256 = "1n2s8b7kya8dnn1d5b0dc8yadl92iwf58s7sb5950b6yyi3i3q7f";
    };
  };

  soong = buildVimPluginFrom2Nix {
    pname = "soong.vim";
    version = "unstable-2023-01-03";
    src = fetchFromGitHub {
      owner = "cherrry";
      repo = "soong.vim";
      rev = "02dc1dd7c56ded823c07d0b6c811e4f2d5ca200a";
      sha256 = "1cqnbh45hhggny3zm7shjiy0nf54hgz2qlbz9bi27qpbks9d5r9r";
    };
  };

  kmonad-vim = buildVimPluginFrom2Nix {
    pname = "kmonad-vim";
    version = "unstable-2022-03-20";
    src = fetchFromGitHub {
      owner = "kmonad";
      repo = "kmonad-vim";
      rev = "37978445197ab00edeb5b731e9ca90c2b141723f";
      sha256 = "13p3i0b8azkmhafyv8hc4hav1pmgqg52xzvk2a3gp3ppqqx9bwpc";
    };
  };
}
