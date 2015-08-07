#!/bin/ruby
require 'vte3'

class MainWindow < Gtk::Window

	def initialize
		super(:toplevel)
		set_title("SES Terminal")
		self.signal_connect("destroy") {
			Gtk.main_quit
		}
		
		$vte = Vte::Terminal.new()
		$vte.visible_bell = false
		$vte.set_scrollback_lines(-1)
		$pty = Vte::Pty.new(:default)
		$vte.set_pty_object($pty)
		self.add($vte)
	end

	def getconfig
		# Default initialize
		self.allow_bold = true
		self.audible_bell = false
  		# self.background-image-file = nil
		# self.background-image-pixbuf = nil
		self.background_opacity = 0
		# self.background-saturation = 0
		self.background_tint_color = Gdk::Color::Back
		self.background_transparent = false
		# self.cursor-blink-mode = <VteTerminalCursorBlinkMode>
		# self.cursor-shape = <VteTerminalCursorShape>
		# self.delete-binding = <VteTerminalEraseBinding>
		self.encoding = "UTF-8"
		# self.font-desc = <PangoFontDescription>
		self.icon_title = "Terminal"
		self.pointer_autohide = true
		self.scroll_background = true
		self.scroll_on_keystroke = true
		self.scroll_on_output = true
		self.scrollback_lines = 255
		self.visible_bell = false
		# Read config
		begin
			config_file = File.open(Glib.getenv("HOME")+"/.config/ATerminal.config")
			while line = config_file.gets.split("=")
				#case line[0]
				#when ""
				#when ""
			end
		rescue Exception
			false
		end
		
	end

end
	
Gtk.init
a = MainWindow.new
a.show_all
$vte.fork_command(GLib.getenv("SHELL"))
$vte.grab_focus
Gtk.main
