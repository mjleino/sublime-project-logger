JsOsaDAS1.001.00bplist00�Vscript_�// prints the title of the topmost sublime text window
try {
	console.log(
		Application("System Events")
			.processes.byName("Sublime Text")
			.windows[0].title()
	)
}
catch (e) {}
""                            �jscr  ��ޭ