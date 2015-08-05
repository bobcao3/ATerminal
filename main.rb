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

end
		
Gtk.init
a = MainWindow.new
a.show_all
$vte.fork_command("zsh")
$vte.set_visible_bell(false)
$vte.set_audible_bell(false)
$vte.grab_focus
Gtk.main
