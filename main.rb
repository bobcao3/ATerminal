#!/bin/ruby
require 'vte3'

class MainWindow < Gtk::Window

	def initialize
		super(:toplevel)
		set_title("SES Terminal")
		self.signal_connect("destroy") {
			Gtk.main_quit
		}
		
		$vte = Terminal.new()
		$pty = Vte::Pty.new(:default)
		$vte.set_pty_object($pty)
		self.add($vte)
	end

end

class Terminal < Vte::Terminal

	def initialize
		super
		getconfig
	end
	
	def getconfig
		# Default initialize
		self.allow_bold = true
		self.audible_bell = false
  		# self.background-image-file = nil
		# self.background-image-pixbuf = nil
		self.background_opacity = 0
		# self.background-saturation = 0
		# self.background_tint_color = <GdkColor>
		self.background_transparent = false
		# self.cursor-blink-mode = <VteTerminalCursorBlinkMode>
		# self.cursor-shape = <VteTerminalCursorShape>
		# self.delete-binding = <VteTerminalEraseBinding>
		self.encoding = "UTF-8"
		# self.font-desc = <PangoFontDescription>
		self.pointer_autohide = true
		self.scroll_background = true
		self.scroll_on_keystroke = true
		self.scroll_on_output = true
		self.scrollback_lines = 255
		self.visible_bell = false
		# Read config
		#begin
			config_file = File.open(GLib.getenv("HOME")+"/.config/ATerminal.config")
			while l = config_file.gets
				line = l.split("=")
				case line[0]
				when "allow_bold"
					self.allow_bold = (line[1] == "true")
				when "audible_bell"
					self.audible_bell = (line[1] == "true")
				when "background_opacity" 
					self.background_opacity = line[1].to_i
				when "background_tint_color"
					# self.background_tint_color = Gdk::Color::Back
				when "background_transparent"
					self.background_transparent = (line[1] == "true")
				when "encoding"
					self.encoding = line[1].split("\n")[0]
				when "pointer_autohide"
					self.pointer_autohide = (line[1] == "true")
				when "scroll_background"
					self.scroll_background = (line[1] == "true")
				when "scroll_on_keystroke"
					self.scroll_on_keystroke = (line[1] == "true")
				when "scroll_on_output"
					self.scroll_on_output = (line[1] == "true")
				when "scrollback_lines"
					self.scrollback_lines = line[1].to_i
				when "visible_bell"
					self.visible_bell = (line[1] == "true")
				end
			end
			config_file.close
		#rescue Exception
		#	false
		#end
		
	end

end
	
Gtk.init
a =MainWindow.new
a.show_all
$vte.fork_command(GLib.getenv("SHELL"))
$vte.grab_focus
Gtk.main
