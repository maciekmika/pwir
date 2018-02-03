with Ada.Text_IO;

with Gdk.Types.Keysyms;
with Glib;
with Gtk.Main;
with Gtk.Search_Entry;

with GNAT.String_Split;




package body Handlers is

procedure Quit (Object : access Gtkada_Builder_Record'Class) is
      pragma Unreferenced (Object);
   begin
      Ada.Text_IO.Put_Line ("Exiting arun");
      Gtk.Main.Main_Quit;
   end Quit;

   end Handlers;
