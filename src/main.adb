with Gtk.Box;         use Gtk.Box;
with Gtk.Label;       use Gtk.Label;
with Gtk.Widget;      use Gtk.Widget;
with Gtk.Main;
with Gtk.Window;      use Gtk.Window;
with Gtk;            use Gtk;
with Glib.Error;     use Glib.Error;
with Gtkada.Builder; use Gtkada.Builder;
with Ada.Text_IO;    use Ada.Text_IO;
with Glib; use Glib;
with Handlers;
with Gtk.Button; use Gtk.Button;



procedure Main is


   Win   : Gtk_Window;
   Label : Gtk_Label;
   Box   : Gtk_Vbox;
   Builder       : Gtkada_Builder;
   Return_Code : Guint;
   Error       : aliased Glib.Error.GError;
   Button : Gtk_Button;

Migration_Interval    : Glib.Guint := 1000;

   procedure BrakeOn (Button : access Gtk_Button_Record'Class) is
begin
         Put_Line("brake on");

   end BrakeOn;

    function Migrate( Number_To_Move : in Integer ) return Boolean is

   begin
      Put_Line("elo" & Number_To_Move'Img);
      return True; -- "false" will disable further timeouts on this.
   end Migrate;




begin

   Gtk.Main.Init;
Gtk_New (Builder);

-- Load `arun.glade` which contains the interface definition
Return_Code := Add_From_File (Builder  => Builder,
                              Filename => "gui.glade",
                              Error    => Error'Access);

if Error /= null then
   Put_Line ("Error : " & Get_Message (Error));
   Error_Free (Error);
   return;
end if;

-- Register a signal handler for when
-- the "Main_Quit" signal is fired


Do_Connect (Builder);

-- Get the Gtk_Widget object from the Gtkada.Builder API
-- for our commandWindow so it will be shown.

   Button := Gtk_Button (Builder.Get_Object ("brakeOn"));
   Button.On_Clicked (BrakeOn'Unrestricted_Access);
   Button.Set_Label("Elo");

  --  Timeout_Callback.Add( Interval => Migration_Interval,
  --                                         Func     => Migrate'Access,
   --                                        D        => 1000 );



Gtk.Widget.Show_All (
    Gtk_Widget (Gtkada.Builder.Get_Object (Builder, "monitorWindow")));

   Gtk.Main.Main;

   Endless_Loop :
   loop

      Button.Set_Label("Ty kurwo jebana");

   end loop Endless_Loop;

--Unref (Builder);

end Main;
