{
	stdenv,
	writeText,
	kalamine,
	# Version number to stamp
	version,
	# Whether to swap the placement of `@` and `<`.
	swap-at-key ? false,
	# Layout name "shown in system settings", no clue where though
	human-name ? "Finnest",
	# The XKB variant string, in effect the name used in linux
	linux-name ? "finnest",
	# The name shown in MacOS, also the description because of an apparent bug in Kalamine?
	macos-name ? "Finnest",
	# Short Windows filename, no clue where it's used
	mshit-name ? "finnest",
	locale ? "fi",
	atHi ? " @ ´ ",
	atLo ? " ' ` ",
	gtHi ? " > ≥ ",
	gtLo ? " < ≤ ",
	...
}: let
	swap = swap-at-key;

	ka =
		if swap
		then atHi
		else gtHi;
	kb =
		if swap
		then atLo
		else gtLo;
	kc =
		if swap
		then gtHi
		else atHi;
	kd =
		if swap
		then gtLo
		else atLo;

	toml =
		writeText "layout.toml"
		# toml
		''
			author = "emsknock"

			name = "${human-name}"
			name8 = "${mshit-name}"
			variant = "${linux-name}"
			description = "${macos-name}"

			locale = "${locale}"
			version = "${version}"
			url = "https://github.com/emsknock/finnest"
			geometry = "ISO"

			full = ${"'''"}
			┌─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┲━━━━━━━━━━┓
			│${ka}│ !   │ "   │ ^   │ $ £ │ %   │ &   │ *   │ (   │ )   │ = ≈ │ ?   │ \   ┃          ┃
			│${kb}│ 1   │ 2   │ 3   │ 4 € │ 5   │ 6 § │ 7   │ 8   │ 9   │ 0 ° │ +   │ / | ┃ ⌫        ┃
			┢━━━━━┷━━┱──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┺━━┳━━━━━━━┫
			┃        ┃ Q   │ W   │ E   │ R   │ T   │ Y   │ U ⇔ │ I ⇕ │ O   │ P   │ {   │ }*^ ┃       ┃
			┃ ↹      ┃     │     │     │   ® │   ™ │     │   ↔ │   ↕ │     │     │ [ å │ ]*¨ ┃       ┃
			┣━━━━━━━━┻┱────┴┬────┴┬────┴┬────┴┬────┴┬────┴┬────┴┬────┴┬────┴┬────┴┬────┴┬────┺┓  ⏎   ┃
			┃         ┃ A   │ S   │ D   │ F   │ G   │ H ⇐ │ J ⇓ │ K ⇑ │ L ⇒ │ Ö   │ Ä   │ ~*~ ┃      ┃
			┃ ⇬       ┃     │     │     │     │     │   ← │   ↓ │   ↑ │   → │   ø │   æ │ #   ┃      ┃
			┣━━━━━━┳━━┹──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┲━━┷━━━━━┻━━━━━━┫
			┃      ┃${kc}│ Z   │ X   │ C   │ V   │ B   │ N   │ M   │ ;   │ : ⋅ │ _ — ┃               ┃
			┃ ⇧    ┃${kd}│     │     │   © │     │     │     │     │ ,   │ . … │ - – ┃ ⇧             ┃
			┣━━━━━━┻┳━━━━┷━━┳━━┷━━━━┱┴─────┴─────┴─────┴─────┴─────┴─┲━━━┷━━━┳━┷━━━━━╋━━━━━━━┳━━━━━━━┫
			┃       ┃       ┃       ┃                                ┃       ┃       ┃       ┃       ┃
			┃ Ctrl  ┃ super ┃ Alt   ┃ ␣                              ┃ AltGr ┃ super ┃ menu  ┃ Ctrl  ┃
			┗━━━━━━━┻━━━━━━━┻━━━━━━━┹────────────────────────────────┺━━━━━━━┻━━━━━━━┻━━━━━━━┻━━━━━━━┛
			${"'''"}
		'';
in
	stdenv.mkDerivation {
		name = "finnest";
		nativeBuildInputs = [kalamine];
		dontUnpack = true;
		buildPhase =
			# bash
			''
				mkdir -p $out
				kalamine build ${toml}
				cp dist/* $out
			'';
	}
