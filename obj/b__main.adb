pragma Warnings (Off);
pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b__main.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b__main.adb");
pragma Suppress (Overflow_Check);
with Ada.Exceptions;

package body ada_main is

   E070 : Short_Integer; pragma Import (Ada, E070, "system__os_lib_E");
   E013 : Short_Integer; pragma Import (Ada, E013, "system__soft_links_E");
   E023 : Short_Integer; pragma Import (Ada, E023, "system__exception_table_E");
   E066 : Short_Integer; pragma Import (Ada, E066, "ada__io_exceptions_E");
   E050 : Short_Integer; pragma Import (Ada, E050, "ada__strings_E");
   E038 : Short_Integer; pragma Import (Ada, E038, "ada__containers_E");
   E025 : Short_Integer; pragma Import (Ada, E025, "system__exceptions_E");
   E017 : Short_Integer; pragma Import (Ada, E017, "system__secondary_stack_E");
   E076 : Short_Integer; pragma Import (Ada, E076, "interfaces__c_E");
   E052 : Short_Integer; pragma Import (Ada, E052, "ada__strings__maps_E");
   E056 : Short_Integer; pragma Import (Ada, E056, "ada__strings__maps__constants_E");
   E078 : Short_Integer; pragma Import (Ada, E078, "system__object_reader_E");
   E045 : Short_Integer; pragma Import (Ada, E045, "system__dwarf_lines_E");
   E037 : Short_Integer; pragma Import (Ada, E037, "system__traceback__symbolic_E");
   E117 : Short_Integer; pragma Import (Ada, E117, "interfaces__c__strings_E");
   E006 : Short_Integer; pragma Import (Ada, E006, "ada__tags_E");
   E105 : Short_Integer; pragma Import (Ada, E105, "ada__streams_E");
   E113 : Short_Integer; pragma Import (Ada, E113, "system__file_control_block_E");
   E112 : Short_Integer; pragma Import (Ada, E112, "system__finalization_root_E");
   E110 : Short_Integer; pragma Import (Ada, E110, "ada__finalization_E");
   E109 : Short_Integer; pragma Import (Ada, E109, "system__file_io_E");
   E377 : Short_Integer; pragma Import (Ada, E377, "ada__streams__stream_io_E");
   E123 : Short_Integer; pragma Import (Ada, E123, "system__storage_pools_E");
   E119 : Short_Integer; pragma Import (Ada, E119, "system__finalization_masters_E");
   E138 : Short_Integer; pragma Import (Ada, E138, "system__storage_pools__subpools_E");
   E365 : Short_Integer; pragma Import (Ada, E365, "ada__strings__unbounded_E");
   E103 : Short_Integer; pragma Import (Ada, E103, "ada__text_io_E");
   E384 : Short_Integer; pragma Import (Ada, E384, "gnat__string_split_E");
   E348 : Short_Integer; pragma Import (Ada, E348, "system__assertions_E");
   E125 : Short_Integer; pragma Import (Ada, E125, "system__pool_global_E");
   E115 : Short_Integer; pragma Import (Ada, E115, "glib_E");
   E155 : Short_Integer; pragma Import (Ada, E155, "gtkada__types_E");
   E211 : Short_Integer; pragma Import (Ada, E211, "gdk__frame_timings_E");
   E157 : Short_Integer; pragma Import (Ada, E157, "glib__glist_E");
   E195 : Short_Integer; pragma Import (Ada, E195, "gdk__visual_E");
   E159 : Short_Integer; pragma Import (Ada, E159, "glib__gslist_E");
   E153 : Short_Integer; pragma Import (Ada, E153, "gtkada__c_E");
   E134 : Short_Integer; pragma Import (Ada, E134, "glib__object_E");
   E151 : Short_Integer; pragma Import (Ada, E151, "glib__values_E");
   E149 : Short_Integer; pragma Import (Ada, E149, "glib__types_E");
   E136 : Short_Integer; pragma Import (Ada, E136, "glib__type_conversion_hooks_E");
   E143 : Short_Integer; pragma Import (Ada, E143, "gtkada__bindings_E");
   E175 : Short_Integer; pragma Import (Ada, E175, "cairo_E");
   E177 : Short_Integer; pragma Import (Ada, E177, "cairo__region_E");
   E182 : Short_Integer; pragma Import (Ada, E182, "gdk__rectangle_E");
   E165 : Short_Integer; pragma Import (Ada, E165, "glib__generic_properties_E");
   E203 : Short_Integer; pragma Import (Ada, E203, "gdk__color_E");
   E185 : Short_Integer; pragma Import (Ada, E185, "gdk__rgba_E");
   E180 : Short_Integer; pragma Import (Ada, E180, "gdk__event_E");
   E302 : Short_Integer; pragma Import (Ada, E302, "glib__key_file_E");
   E163 : Short_Integer; pragma Import (Ada, E163, "glib__properties_E");
   E262 : Short_Integer; pragma Import (Ada, E262, "glib__string_E");
   E260 : Short_Integer; pragma Import (Ada, E260, "glib__variant_E");
   E258 : Short_Integer; pragma Import (Ada, E258, "glib__g_icon_E");
   E328 : Short_Integer; pragma Import (Ada, E328, "gtk__actionable_E");
   E169 : Short_Integer; pragma Import (Ada, E169, "gtk__builder_E");
   E167 : Short_Integer; pragma Import (Ada, E167, "gtk__buildable_E");
   E276 : Short_Integer; pragma Import (Ada, E276, "gtk__cell_area_context_E");
   E292 : Short_Integer; pragma Import (Ada, E292, "gtk__css_section_E");
   E197 : Short_Integer; pragma Import (Ada, E197, "gtk__enums_E");
   E316 : Short_Integer; pragma Import (Ada, E316, "gtk__orientable_E");
   E304 : Short_Integer; pragma Import (Ada, E304, "gtk__paper_size_E");
   E300 : Short_Integer; pragma Import (Ada, E300, "gtk__page_setup_E");
   E312 : Short_Integer; pragma Import (Ada, E312, "gtk__print_settings_E");
   E223 : Short_Integer; pragma Import (Ada, E223, "gtk__target_entry_E");
   E221 : Short_Integer; pragma Import (Ada, E221, "gtk__target_list_E");
   E228 : Short_Integer; pragma Import (Ada, E228, "pango__enums_E");
   E246 : Short_Integer; pragma Import (Ada, E246, "pango__attributes_E");
   E232 : Short_Integer; pragma Import (Ada, E232, "pango__font_metrics_E");
   E234 : Short_Integer; pragma Import (Ada, E234, "pango__language_E");
   E230 : Short_Integer; pragma Import (Ada, E230, "pango__font_E");
   E320 : Short_Integer; pragma Import (Ada, E320, "gtk__text_attributes_E");
   E322 : Short_Integer; pragma Import (Ada, E322, "gtk__text_tag_E");
   E238 : Short_Integer; pragma Import (Ada, E238, "pango__font_face_E");
   E236 : Short_Integer; pragma Import (Ada, E236, "pango__font_family_E");
   E240 : Short_Integer; pragma Import (Ada, E240, "pango__fontset_E");
   E242 : Short_Integer; pragma Import (Ada, E242, "pango__matrix_E");
   E226 : Short_Integer; pragma Import (Ada, E226, "pango__context_E");
   E308 : Short_Integer; pragma Import (Ada, E308, "pango__font_map_E");
   E248 : Short_Integer; pragma Import (Ada, E248, "pango__tabs_E");
   E244 : Short_Integer; pragma Import (Ada, E244, "pango__layout_E");
   E306 : Short_Integer; pragma Import (Ada, E306, "gtk__print_context_E");
   E193 : Short_Integer; pragma Import (Ada, E193, "gdk__display_E");
   E310 : Short_Integer; pragma Import (Ada, E310, "gtk__print_operation_preview_E");
   E282 : Short_Integer; pragma Import (Ada, E282, "gtk__tree_model_E");
   E270 : Short_Integer; pragma Import (Ada, E270, "gtk__entry_buffer_E");
   E268 : Short_Integer; pragma Import (Ada, E268, "gtk__editable_E");
   E266 : Short_Integer; pragma Import (Ada, E266, "gtk__cell_editable_E");
   E264 : Short_Integer; pragma Import (Ada, E264, "gtk__adjustment_E");
   E219 : Short_Integer; pragma Import (Ada, E219, "gtk__style_E");
   E215 : Short_Integer; pragma Import (Ada, E215, "gtk__accel_group_E");
   E209 : Short_Integer; pragma Import (Ada, E209, "gdk__frame_clock_E");
   E213 : Short_Integer; pragma Import (Ada, E213, "gdk__pixbuf_E");
   E288 : Short_Integer; pragma Import (Ada, E288, "gtk__icon_source_E");
   E191 : Short_Integer; pragma Import (Ada, E191, "gdk__screen_E");
   E318 : Short_Integer; pragma Import (Ada, E318, "gtk__text_iter_E");
   E217 : Short_Integer; pragma Import (Ada, E217, "gtk__selection_data_E");
   E205 : Short_Integer; pragma Import (Ada, E205, "gdk__device_E");
   E207 : Short_Integer; pragma Import (Ada, E207, "gdk__drag_contexts_E");
   E201 : Short_Integer; pragma Import (Ada, E201, "gtk__widget_E");
   E294 : Short_Integer; pragma Import (Ada, E294, "gtk__misc_E");
   E199 : Short_Integer; pragma Import (Ada, E199, "gtk__style_provider_E");
   E189 : Short_Integer; pragma Import (Ada, E189, "gtk__settings_E");
   E252 : Short_Integer; pragma Import (Ada, E252, "gdk__window_E");
   E290 : Short_Integer; pragma Import (Ada, E290, "gtk__style_context_E");
   E286 : Short_Integer; pragma Import (Ada, E286, "gtk__icon_set_E");
   E284 : Short_Integer; pragma Import (Ada, E284, "gtk__image_E");
   E280 : Short_Integer; pragma Import (Ada, E280, "gtk__cell_renderer_E");
   E171 : Short_Integer; pragma Import (Ada, E171, "gtk__container_E");
   E254 : Short_Integer; pragma Import (Ada, E254, "gtk__bin_E");
   E250 : Short_Integer; pragma Import (Ada, E250, "gtk__window_E");
   E161 : Short_Integer; pragma Import (Ada, E161, "gtk__box_E");
   E314 : Short_Integer; pragma Import (Ada, E314, "gtk__status_bar_E");
   E298 : Short_Integer; pragma Import (Ada, E298, "gtk__print_operation_E");
   E296 : Short_Integer; pragma Import (Ada, E296, "gtk__notebook_E");
   E278 : Short_Integer; pragma Import (Ada, E278, "gtk__cell_layout_E");
   E274 : Short_Integer; pragma Import (Ada, E274, "gtk__cell_area_E");
   E272 : Short_Integer; pragma Import (Ada, E272, "gtk__entry_completion_E");
   E187 : Short_Integer; pragma Import (Ada, E187, "gtk__dialog_E");
   E256 : Short_Integer; pragma Import (Ada, E256, "gtk__gentry_E");
   E173 : Short_Integer; pragma Import (Ada, E173, "gtk__arguments_E");
   E336 : Short_Integer; pragma Import (Ada, E336, "glib__menu_model_E");
   E326 : Short_Integer; pragma Import (Ada, E326, "gtk__action_E");
   E330 : Short_Integer; pragma Import (Ada, E330, "gtk__activatable_E");
   E324 : Short_Integer; pragma Import (Ada, E324, "gtk__button_E");
   E342 : Short_Integer; pragma Import (Ada, E342, "gtk__main_E");
   E350 : Short_Integer; pragma Import (Ada, E350, "gtk__marshallers_E");
   E338 : Short_Integer; pragma Import (Ada, E338, "gtk__menu_item_E");
   E340 : Short_Integer; pragma Import (Ada, E340, "gtk__menu_shell_E");
   E334 : Short_Integer; pragma Import (Ada, E334, "gtk__menu_E");
   E332 : Short_Integer; pragma Import (Ada, E332, "gtk__label_E");
   E386 : Short_Integer; pragma Import (Ada, E386, "gtk__search_entry_E");
   E352 : Short_Integer; pragma Import (Ada, E352, "gtk__tree_view_column_E");
   E353 : Short_Integer; pragma Import (Ada, E353, "gtkada__handlers_E");
   E344 : Short_Integer; pragma Import (Ada, E344, "gtkada__builder_E");
   E381 : Short_Integer; pragma Import (Ada, E381, "handlers_E");

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
   begin
      declare
         procedure F1;
         pragma Import (Ada, F1, "gtkada__builder__finalize_body");
      begin
         E344 := E344 - 1;
         F1;
      end;
      declare
         procedure F2;
         pragma Import (Ada, F2, "gtkada__builder__finalize_spec");
      begin
         F2;
      end;
      declare
         procedure F3;
         pragma Import (Ada, F3, "gtkada__handlers__finalize_spec");
      begin
         E353 := E353 - 1;
         F3;
      end;
      E352 := E352 - 1;
      declare
         procedure F4;
         pragma Import (Ada, F4, "gtk__tree_view_column__finalize_spec");
      begin
         F4;
      end;
      E386 := E386 - 1;
      declare
         procedure F5;
         pragma Import (Ada, F5, "gtk__search_entry__finalize_spec");
      begin
         F5;
      end;
      E332 := E332 - 1;
      declare
         procedure F6;
         pragma Import (Ada, F6, "gtk__label__finalize_spec");
      begin
         F6;
      end;
      E334 := E334 - 1;
      declare
         procedure F7;
         pragma Import (Ada, F7, "gtk__menu__finalize_spec");
      begin
         F7;
      end;
      E340 := E340 - 1;
      declare
         procedure F8;
         pragma Import (Ada, F8, "gtk__menu_shell__finalize_spec");
      begin
         F8;
      end;
      E338 := E338 - 1;
      declare
         procedure F9;
         pragma Import (Ada, F9, "gtk__menu_item__finalize_spec");
      begin
         F9;
      end;
      E324 := E324 - 1;
      declare
         procedure F10;
         pragma Import (Ada, F10, "gtk__button__finalize_spec");
      begin
         F10;
      end;
      E326 := E326 - 1;
      declare
         procedure F11;
         pragma Import (Ada, F11, "gtk__action__finalize_spec");
      begin
         F11;
      end;
      E336 := E336 - 1;
      declare
         procedure F12;
         pragma Import (Ada, F12, "glib__menu_model__finalize_spec");
      begin
         F12;
      end;
      E193 := E193 - 1;
      E209 := E209 - 1;
      E215 := E215 - 1;
      E201 := E201 - 1;
      E219 := E219 - 1;
      E171 := E171 - 1;
      E187 := E187 - 1;
      E250 := E250 - 1;
      E264 := E264 - 1;
      E270 := E270 - 1;
      E280 := E280 - 1;
      E272 := E272 - 1;
      E274 := E274 - 1;
      E282 := E282 - 1;
      E256 := E256 - 1;
      E290 := E290 - 1;
      E296 := E296 - 1;
      E298 := E298 - 1;
      E314 := E314 - 1;
      declare
         procedure F13;
         pragma Import (Ada, F13, "gtk__gentry__finalize_spec");
      begin
         F13;
      end;
      declare
         procedure F14;
         pragma Import (Ada, F14, "gtk__dialog__finalize_spec");
      begin
         F14;
      end;
      declare
         procedure F15;
         pragma Import (Ada, F15, "gtk__entry_completion__finalize_spec");
      begin
         F15;
      end;
      declare
         procedure F16;
         pragma Import (Ada, F16, "gtk__cell_area__finalize_spec");
      begin
         F16;
      end;
      declare
         procedure F17;
         pragma Import (Ada, F17, "gtk__notebook__finalize_spec");
      begin
         F17;
      end;
      declare
         procedure F18;
         pragma Import (Ada, F18, "gtk__print_operation__finalize_spec");
      begin
         F18;
      end;
      declare
         procedure F19;
         pragma Import (Ada, F19, "gtk__status_bar__finalize_spec");
      begin
         F19;
      end;
      E161 := E161 - 1;
      declare
         procedure F20;
         pragma Import (Ada, F20, "gtk__box__finalize_spec");
      begin
         F20;
      end;
      declare
         procedure F21;
         pragma Import (Ada, F21, "gtk__window__finalize_spec");
      begin
         F21;
      end;
      E254 := E254 - 1;
      declare
         procedure F22;
         pragma Import (Ada, F22, "gtk__bin__finalize_spec");
      begin
         F22;
      end;
      declare
         procedure F23;
         pragma Import (Ada, F23, "gtk__container__finalize_spec");
      begin
         F23;
      end;
      declare
         procedure F24;
         pragma Import (Ada, F24, "gtk__cell_renderer__finalize_spec");
      begin
         F24;
      end;
      E284 := E284 - 1;
      declare
         procedure F25;
         pragma Import (Ada, F25, "gtk__image__finalize_spec");
      begin
         F25;
      end;
      E286 := E286 - 1;
      declare
         procedure F26;
         pragma Import (Ada, F26, "gtk__icon_set__finalize_spec");
      begin
         F26;
      end;
      declare
         procedure F27;
         pragma Import (Ada, F27, "gtk__style_context__finalize_spec");
      begin
         F27;
      end;
      E189 := E189 - 1;
      declare
         procedure F28;
         pragma Import (Ada, F28, "gtk__settings__finalize_spec");
      begin
         F28;
      end;
      E294 := E294 - 1;
      declare
         procedure F29;
         pragma Import (Ada, F29, "gtk__misc__finalize_spec");
      begin
         F29;
      end;
      declare
         procedure F30;
         pragma Import (Ada, F30, "gtk__widget__finalize_spec");
      begin
         F30;
      end;
      E205 := E205 - 1;
      E207 := E207 - 1;
      declare
         procedure F31;
         pragma Import (Ada, F31, "gdk__drag_contexts__finalize_spec");
      begin
         F31;
      end;
      declare
         procedure F32;
         pragma Import (Ada, F32, "gdk__device__finalize_spec");
      begin
         F32;
      end;
      E217 := E217 - 1;
      declare
         procedure F33;
         pragma Import (Ada, F33, "gtk__selection_data__finalize_spec");
      begin
         F33;
      end;
      E191 := E191 - 1;
      declare
         procedure F34;
         pragma Import (Ada, F34, "gdk__screen__finalize_spec");
      begin
         F34;
      end;
      E213 := E213 - 1;
      E288 := E288 - 1;
      declare
         procedure F35;
         pragma Import (Ada, F35, "gtk__icon_source__finalize_spec");
      begin
         F35;
      end;
      declare
         procedure F36;
         pragma Import (Ada, F36, "gdk__pixbuf__finalize_spec");
      begin
         F36;
      end;
      declare
         procedure F37;
         pragma Import (Ada, F37, "gdk__frame_clock__finalize_spec");
      begin
         F37;
      end;
      declare
         procedure F38;
         pragma Import (Ada, F38, "gtk__accel_group__finalize_spec");
      begin
         F38;
      end;
      declare
         procedure F39;
         pragma Import (Ada, F39, "gtk__style__finalize_spec");
      begin
         F39;
      end;
      declare
         procedure F40;
         pragma Import (Ada, F40, "gtk__adjustment__finalize_spec");
      begin
         F40;
      end;
      declare
         procedure F41;
         pragma Import (Ada, F41, "gtk__entry_buffer__finalize_spec");
      begin
         F41;
      end;
      declare
         procedure F42;
         pragma Import (Ada, F42, "gtk__tree_model__finalize_spec");
      begin
         F42;
      end;
      declare
         procedure F43;
         pragma Import (Ada, F43, "gdk__display__finalize_spec");
      begin
         F43;
      end;
      E306 := E306 - 1;
      declare
         procedure F44;
         pragma Import (Ada, F44, "gtk__print_context__finalize_spec");
      begin
         F44;
      end;
      E244 := E244 - 1;
      declare
         procedure F45;
         pragma Import (Ada, F45, "pango__layout__finalize_spec");
      begin
         F45;
      end;
      E248 := E248 - 1;
      declare
         procedure F46;
         pragma Import (Ada, F46, "pango__tabs__finalize_spec");
      begin
         F46;
      end;
      E308 := E308 - 1;
      declare
         procedure F47;
         pragma Import (Ada, F47, "pango__font_map__finalize_spec");
      begin
         F47;
      end;
      E226 := E226 - 1;
      declare
         procedure F48;
         pragma Import (Ada, F48, "pango__context__finalize_spec");
      begin
         F48;
      end;
      E240 := E240 - 1;
      declare
         procedure F49;
         pragma Import (Ada, F49, "pango__fontset__finalize_spec");
      begin
         F49;
      end;
      E236 := E236 - 1;
      declare
         procedure F50;
         pragma Import (Ada, F50, "pango__font_family__finalize_spec");
      begin
         F50;
      end;
      E238 := E238 - 1;
      declare
         procedure F51;
         pragma Import (Ada, F51, "pango__font_face__finalize_spec");
      begin
         F51;
      end;
      E322 := E322 - 1;
      declare
         procedure F52;
         pragma Import (Ada, F52, "gtk__text_tag__finalize_spec");
      begin
         F52;
      end;
      E230 := E230 - 1;
      declare
         procedure F53;
         pragma Import (Ada, F53, "pango__font__finalize_spec");
      begin
         F53;
      end;
      E234 := E234 - 1;
      declare
         procedure F54;
         pragma Import (Ada, F54, "pango__language__finalize_spec");
      begin
         F54;
      end;
      E232 := E232 - 1;
      declare
         procedure F55;
         pragma Import (Ada, F55, "pango__font_metrics__finalize_spec");
      begin
         F55;
      end;
      E246 := E246 - 1;
      declare
         procedure F56;
         pragma Import (Ada, F56, "pango__attributes__finalize_spec");
      begin
         F56;
      end;
      E221 := E221 - 1;
      declare
         procedure F57;
         pragma Import (Ada, F57, "gtk__target_list__finalize_spec");
      begin
         F57;
      end;
      E312 := E312 - 1;
      declare
         procedure F58;
         pragma Import (Ada, F58, "gtk__print_settings__finalize_spec");
      begin
         F58;
      end;
      E300 := E300 - 1;
      declare
         procedure F59;
         pragma Import (Ada, F59, "gtk__page_setup__finalize_spec");
      begin
         F59;
      end;
      E304 := E304 - 1;
      declare
         procedure F60;
         pragma Import (Ada, F60, "gtk__paper_size__finalize_spec");
      begin
         F60;
      end;
      E292 := E292 - 1;
      declare
         procedure F61;
         pragma Import (Ada, F61, "gtk__css_section__finalize_spec");
      begin
         F61;
      end;
      E276 := E276 - 1;
      declare
         procedure F62;
         pragma Import (Ada, F62, "gtk__cell_area_context__finalize_spec");
      begin
         F62;
      end;
      E169 := E169 - 1;
      declare
         procedure F63;
         pragma Import (Ada, F63, "gtk__builder__finalize_spec");
      begin
         F63;
      end;
      E260 := E260 - 1;
      declare
         procedure F64;
         pragma Import (Ada, F64, "glib__variant__finalize_spec");
      begin
         F64;
      end;
      E134 := E134 - 1;
      declare
         procedure F65;
         pragma Import (Ada, F65, "glib__object__finalize_spec");
      begin
         F65;
      end;
      E211 := E211 - 1;
      declare
         procedure F66;
         pragma Import (Ada, F66, "gdk__frame_timings__finalize_spec");
      begin
         F66;
      end;
      E115 := E115 - 1;
      declare
         procedure F67;
         pragma Import (Ada, F67, "glib__finalize_spec");
      begin
         F67;
      end;
      E125 := E125 - 1;
      declare
         procedure F68;
         pragma Import (Ada, F68, "system__pool_global__finalize_spec");
      begin
         F68;
      end;
      E103 := E103 - 1;
      declare
         procedure F69;
         pragma Import (Ada, F69, "ada__text_io__finalize_spec");
      begin
         F69;
      end;
      E365 := E365 - 1;
      declare
         procedure F70;
         pragma Import (Ada, F70, "ada__strings__unbounded__finalize_spec");
      begin
         F70;
      end;
      E138 := E138 - 1;
      declare
         procedure F71;
         pragma Import (Ada, F71, "system__storage_pools__subpools__finalize_spec");
      begin
         F71;
      end;
      E119 := E119 - 1;
      declare
         procedure F72;
         pragma Import (Ada, F72, "system__finalization_masters__finalize_spec");
      begin
         F72;
      end;
      E377 := E377 - 1;
      declare
         procedure F73;
         pragma Import (Ada, F73, "ada__streams__stream_io__finalize_spec");
      begin
         F73;
      end;
      declare
         procedure F74;
         pragma Import (Ada, F74, "system__file_io__finalize_body");
      begin
         E109 := E109 - 1;
         F74;
      end;
      declare
         procedure Reraise_Library_Exception_If_Any;
            pragma Import (Ada, Reraise_Library_Exception_If_Any, "__gnat_reraise_library_exception_if_any");
      begin
         Reraise_Library_Exception_If_Any;
      end;
   end finalize_library;

   procedure adafinal is
      procedure s_stalib_adafinal;
      pragma Import (C, s_stalib_adafinal, "system__standard_library__adafinal");

      procedure Runtime_Finalize;
      pragma Import (C, Runtime_Finalize, "__gnat_runtime_finalize");

   begin
      if not Is_Elaborated then
         return;
      end if;
      Is_Elaborated := False;
      Runtime_Finalize;
      s_stalib_adafinal;
   end adafinal;

   type No_Param_Proc is access procedure;

   procedure adainit is
      Main_Priority : Integer;
      pragma Import (C, Main_Priority, "__gl_main_priority");
      Time_Slice_Value : Integer;
      pragma Import (C, Time_Slice_Value, "__gl_time_slice_val");
      WC_Encoding : Character;
      pragma Import (C, WC_Encoding, "__gl_wc_encoding");
      Locking_Policy : Character;
      pragma Import (C, Locking_Policy, "__gl_locking_policy");
      Queuing_Policy : Character;
      pragma Import (C, Queuing_Policy, "__gl_queuing_policy");
      Task_Dispatching_Policy : Character;
      pragma Import (C, Task_Dispatching_Policy, "__gl_task_dispatching_policy");
      Priority_Specific_Dispatching : System.Address;
      pragma Import (C, Priority_Specific_Dispatching, "__gl_priority_specific_dispatching");
      Num_Specific_Dispatching : Integer;
      pragma Import (C, Num_Specific_Dispatching, "__gl_num_specific_dispatching");
      Main_CPU : Integer;
      pragma Import (C, Main_CPU, "__gl_main_cpu");
      Interrupt_States : System.Address;
      pragma Import (C, Interrupt_States, "__gl_interrupt_states");
      Num_Interrupt_States : Integer;
      pragma Import (C, Num_Interrupt_States, "__gl_num_interrupt_states");
      Unreserve_All_Interrupts : Integer;
      pragma Import (C, Unreserve_All_Interrupts, "__gl_unreserve_all_interrupts");
      Detect_Blocking : Integer;
      pragma Import (C, Detect_Blocking, "__gl_detect_blocking");
      Default_Stack_Size : Integer;
      pragma Import (C, Default_Stack_Size, "__gl_default_stack_size");
      Leap_Seconds_Support : Integer;
      pragma Import (C, Leap_Seconds_Support, "__gl_leap_seconds_support");
      Bind_Env_Addr : System.Address;
      pragma Import (C, Bind_Env_Addr, "__gl_bind_env_addr");

      procedure Runtime_Initialize (Install_Handler : Integer);
      pragma Import (C, Runtime_Initialize, "__gnat_runtime_initialize");

      Finalize_Library_Objects : No_Param_Proc;
      pragma Import (C, Finalize_Library_Objects, "__gnat_finalize_library_objects");
   begin
      if Is_Elaborated then
         return;
      end if;
      Is_Elaborated := True;
      Main_Priority := -1;
      Time_Slice_Value := -1;
      WC_Encoding := 'b';
      Locking_Policy := ' ';
      Queuing_Policy := ' ';
      Task_Dispatching_Policy := ' ';
      Priority_Specific_Dispatching :=
        Local_Priority_Specific_Dispatching'Address;
      Num_Specific_Dispatching := 0;
      Main_CPU := -1;
      Interrupt_States := Local_Interrupt_States'Address;
      Num_Interrupt_States := 0;
      Unreserve_All_Interrupts := 0;
      Detect_Blocking := 0;
      Default_Stack_Size := -1;
      Leap_Seconds_Support := 0;

      Runtime_Initialize (1);

      Finalize_Library_Objects := finalize_library'access;

      System.Soft_Links'Elab_Spec;
      System.Exception_Table'Elab_Body;
      E023 := E023 + 1;
      Ada.Io_Exceptions'Elab_Spec;
      E066 := E066 + 1;
      Ada.Strings'Elab_Spec;
      E050 := E050 + 1;
      Ada.Containers'Elab_Spec;
      E038 := E038 + 1;
      System.Exceptions'Elab_Spec;
      E025 := E025 + 1;
      System.Soft_Links'Elab_Body;
      E013 := E013 + 1;
      Interfaces.C'Elab_Spec;
      System.Os_Lib'Elab_Body;
      E070 := E070 + 1;
      Ada.Strings.Maps'Elab_Spec;
      Ada.Strings.Maps.Constants'Elab_Spec;
      E056 := E056 + 1;
      System.Secondary_Stack'Elab_Body;
      E017 := E017 + 1;
      System.Object_Reader'Elab_Spec;
      System.Dwarf_Lines'Elab_Spec;
      E045 := E045 + 1;
      E076 := E076 + 1;
      E052 := E052 + 1;
      System.Traceback.Symbolic'Elab_Body;
      E037 := E037 + 1;
      E078 := E078 + 1;
      Interfaces.C.Strings'Elab_Spec;
      E117 := E117 + 1;
      Ada.Tags'Elab_Spec;
      Ada.Tags'Elab_Body;
      E006 := E006 + 1;
      Ada.Streams'Elab_Spec;
      E105 := E105 + 1;
      System.File_Control_Block'Elab_Spec;
      E113 := E113 + 1;
      System.Finalization_Root'Elab_Spec;
      E112 := E112 + 1;
      Ada.Finalization'Elab_Spec;
      E110 := E110 + 1;
      System.File_Io'Elab_Body;
      E109 := E109 + 1;
      Ada.Streams.Stream_Io'Elab_Spec;
      E377 := E377 + 1;
      System.Storage_Pools'Elab_Spec;
      E123 := E123 + 1;
      System.Finalization_Masters'Elab_Spec;
      System.Finalization_Masters'Elab_Body;
      E119 := E119 + 1;
      System.Storage_Pools.Subpools'Elab_Spec;
      E138 := E138 + 1;
      Ada.Strings.Unbounded'Elab_Spec;
      E365 := E365 + 1;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E103 := E103 + 1;
      Gnat.String_Split'Elab_Spec;
      E384 := E384 + 1;
      System.Assertions'Elab_Spec;
      E348 := E348 + 1;
      System.Pool_Global'Elab_Spec;
      E125 := E125 + 1;
      Glib'Elab_Spec;
      E115 := E115 + 1;
      Gtkada.Types'Elab_Spec;
      E155 := E155 + 1;
      Gdk.Frame_Timings'Elab_Spec;
      Gdk.Frame_Timings'Elab_Body;
      E211 := E211 + 1;
      E157 := E157 + 1;
      Gdk.Visual'Elab_Body;
      E195 := E195 + 1;
      E159 := E159 + 1;
      E153 := E153 + 1;
      Glib.Object'Elab_Spec;
      Glib.Values'Elab_Body;
      E151 := E151 + 1;
      E136 := E136 + 1;
      E149 := E149 + 1;
      E143 := E143 + 1;
      Glib.Object'Elab_Body;
      E134 := E134 + 1;
      E175 := E175 + 1;
      E177 := E177 + 1;
      E182 := E182 + 1;
      Glib.Generic_Properties'Elab_Spec;
      Glib.Generic_Properties'Elab_Body;
      E165 := E165 + 1;
      Gdk.Color'Elab_Spec;
      E203 := E203 + 1;
      E185 := E185 + 1;
      E180 := E180 + 1;
      E302 := E302 + 1;
      E163 := E163 + 1;
      E262 := E262 + 1;
      Glib.Variant'Elab_Spec;
      Glib.Variant'Elab_Body;
      E260 := E260 + 1;
      E258 := E258 + 1;
      Gtk.Actionable'Elab_Spec;
      E328 := E328 + 1;
      Gtk.Builder'Elab_Spec;
      Gtk.Builder'Elab_Body;
      E169 := E169 + 1;
      E167 := E167 + 1;
      Gtk.Cell_Area_Context'Elab_Spec;
      Gtk.Cell_Area_Context'Elab_Body;
      E276 := E276 + 1;
      Gtk.Css_Section'Elab_Spec;
      Gtk.Css_Section'Elab_Body;
      E292 := E292 + 1;
      E197 := E197 + 1;
      Gtk.Orientable'Elab_Spec;
      E316 := E316 + 1;
      Gtk.Paper_Size'Elab_Spec;
      Gtk.Paper_Size'Elab_Body;
      E304 := E304 + 1;
      Gtk.Page_Setup'Elab_Spec;
      Gtk.Page_Setup'Elab_Body;
      E300 := E300 + 1;
      Gtk.Print_Settings'Elab_Spec;
      Gtk.Print_Settings'Elab_Body;
      E312 := E312 + 1;
      E223 := E223 + 1;
      Gtk.Target_List'Elab_Spec;
      Gtk.Target_List'Elab_Body;
      E221 := E221 + 1;
      E228 := E228 + 1;
      Pango.Attributes'Elab_Spec;
      Pango.Attributes'Elab_Body;
      E246 := E246 + 1;
      Pango.Font_Metrics'Elab_Spec;
      Pango.Font_Metrics'Elab_Body;
      E232 := E232 + 1;
      Pango.Language'Elab_Spec;
      Pango.Language'Elab_Body;
      E234 := E234 + 1;
      Pango.Font'Elab_Spec;
      Pango.Font'Elab_Body;
      E230 := E230 + 1;
      E320 := E320 + 1;
      Gtk.Text_Tag'Elab_Spec;
      Gtk.Text_Tag'Elab_Body;
      E322 := E322 + 1;
      Pango.Font_Face'Elab_Spec;
      Pango.Font_Face'Elab_Body;
      E238 := E238 + 1;
      Pango.Font_Family'Elab_Spec;
      Pango.Font_Family'Elab_Body;
      E236 := E236 + 1;
      Pango.Fontset'Elab_Spec;
      Pango.Fontset'Elab_Body;
      E240 := E240 + 1;
      E242 := E242 + 1;
      Pango.Context'Elab_Spec;
      Pango.Context'Elab_Body;
      E226 := E226 + 1;
      Pango.Font_Map'Elab_Spec;
      Pango.Font_Map'Elab_Body;
      E308 := E308 + 1;
      Pango.Tabs'Elab_Spec;
      Pango.Tabs'Elab_Body;
      E248 := E248 + 1;
      Pango.Layout'Elab_Spec;
      Pango.Layout'Elab_Body;
      E244 := E244 + 1;
      Gtk.Print_Context'Elab_Spec;
      Gtk.Print_Context'Elab_Body;
      E306 := E306 + 1;
      Gdk.Display'Elab_Spec;
      Gtk.Tree_Model'Elab_Spec;
      Gtk.Entry_Buffer'Elab_Spec;
      Gtk.Cell_Editable'Elab_Spec;
      Gtk.Adjustment'Elab_Spec;
      Gtk.Style'Elab_Spec;
      Gtk.Accel_Group'Elab_Spec;
      Gdk.Frame_Clock'Elab_Spec;
      Gdk.Pixbuf'Elab_Spec;
      Gtk.Icon_Source'Elab_Spec;
      Gtk.Icon_Source'Elab_Body;
      E288 := E288 + 1;
      E213 := E213 + 1;
      Gdk.Screen'Elab_Spec;
      Gdk.Screen'Elab_Body;
      E191 := E191 + 1;
      E318 := E318 + 1;
      Gtk.Selection_Data'Elab_Spec;
      Gtk.Selection_Data'Elab_Body;
      E217 := E217 + 1;
      Gdk.Device'Elab_Spec;
      Gdk.Drag_Contexts'Elab_Spec;
      Gdk.Drag_Contexts'Elab_Body;
      E207 := E207 + 1;
      Gdk.Device'Elab_Body;
      E205 := E205 + 1;
      Gtk.Widget'Elab_Spec;
      Gtk.Misc'Elab_Spec;
      Gtk.Misc'Elab_Body;
      E294 := E294 + 1;
      E199 := E199 + 1;
      Gtk.Settings'Elab_Spec;
      Gtk.Settings'Elab_Body;
      E189 := E189 + 1;
      Gdk.Window'Elab_Spec;
      E252 := E252 + 1;
      Gtk.Style_Context'Elab_Spec;
      Gtk.Icon_Set'Elab_Spec;
      Gtk.Icon_Set'Elab_Body;
      E286 := E286 + 1;
      Gtk.Image'Elab_Spec;
      Gtk.Image'Elab_Body;
      E284 := E284 + 1;
      Gtk.Cell_Renderer'Elab_Spec;
      Gtk.Container'Elab_Spec;
      Gtk.Bin'Elab_Spec;
      Gtk.Bin'Elab_Body;
      E254 := E254 + 1;
      Gtk.Window'Elab_Spec;
      Gtk.Box'Elab_Spec;
      Gtk.Box'Elab_Body;
      E161 := E161 + 1;
      Gtk.Status_Bar'Elab_Spec;
      Gtk.Print_Operation'Elab_Spec;
      Gtk.Notebook'Elab_Spec;
      E278 := E278 + 1;
      Gtk.Cell_Area'Elab_Spec;
      Gtk.Entry_Completion'Elab_Spec;
      Gtk.Dialog'Elab_Spec;
      Gtk.Gentry'Elab_Spec;
      Gtk.Status_Bar'Elab_Body;
      E314 := E314 + 1;
      E310 := E310 + 1;
      Gtk.Print_Operation'Elab_Body;
      E298 := E298 + 1;
      Gtk.Notebook'Elab_Body;
      E296 := E296 + 1;
      Gtk.Style_Context'Elab_Body;
      E290 := E290 + 1;
      Gtk.Gentry'Elab_Body;
      E256 := E256 + 1;
      Gtk.Tree_Model'Elab_Body;
      E282 := E282 + 1;
      Gtk.Cell_Area'Elab_Body;
      E274 := E274 + 1;
      Gtk.Entry_Completion'Elab_Body;
      E272 := E272 + 1;
      Gtk.Cell_Renderer'Elab_Body;
      E280 := E280 + 1;
      Gtk.Entry_Buffer'Elab_Body;
      E270 := E270 + 1;
      E268 := E268 + 1;
      E266 := E266 + 1;
      Gtk.Adjustment'Elab_Body;
      E264 := E264 + 1;
      Gtk.Window'Elab_Body;
      E250 := E250 + 1;
      Gtk.Dialog'Elab_Body;
      E187 := E187 + 1;
      Gtk.Container'Elab_Body;
      E171 := E171 + 1;
      Gtk.Style'Elab_Body;
      E219 := E219 + 1;
      Gtk.Widget'Elab_Body;
      E201 := E201 + 1;
      Gtk.Accel_Group'Elab_Body;
      E215 := E215 + 1;
      Gdk.Frame_Clock'Elab_Body;
      E209 := E209 + 1;
      Gdk.Display'Elab_Body;
      E193 := E193 + 1;
      E173 := E173 + 1;
      Glib.Menu_Model'Elab_Spec;
      Glib.Menu_Model'Elab_Body;
      E336 := E336 + 1;
      Gtk.Action'Elab_Spec;
      Gtk.Action'Elab_Body;
      E326 := E326 + 1;
      Gtk.Activatable'Elab_Spec;
      E330 := E330 + 1;
      Gtk.Button'Elab_Spec;
      Gtk.Button'Elab_Body;
      E324 := E324 + 1;
      E342 := E342 + 1;
      E350 := E350 + 1;
      Gtk.Menu_Item'Elab_Spec;
      Gtk.Menu_Item'Elab_Body;
      E338 := E338 + 1;
      Gtk.Menu_Shell'Elab_Spec;
      Gtk.Menu_Shell'Elab_Body;
      E340 := E340 + 1;
      Gtk.Menu'Elab_Spec;
      Gtk.Menu'Elab_Body;
      E334 := E334 + 1;
      Gtk.Label'Elab_Spec;
      Gtk.Label'Elab_Body;
      E332 := E332 + 1;
      Gtk.Search_Entry'Elab_Spec;
      Gtk.Search_Entry'Elab_Body;
      E386 := E386 + 1;
      Gtk.Tree_View_Column'Elab_Spec;
      Gtk.Tree_View_Column'Elab_Body;
      E352 := E352 + 1;
      Gtkada.Handlers'Elab_Spec;
      E353 := E353 + 1;
      Gtkada.Builder'Elab_Spec;
      Gtkada.Builder'Elab_Body;
      E344 := E344 + 1;
      E381 := E381 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_main");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer
   is
      procedure Initialize (Addr : System.Address);
      pragma Import (C, Initialize, "__gnat_initialize");

      procedure Finalize;
      pragma Import (C, Finalize, "__gnat_finalize");
      SEH : aliased array (1 .. 2) of Integer;

      Ensure_Reference : aliased System.Address := Ada_Main_Program_Name'Address;
      pragma Volatile (Ensure_Reference);

   begin
      gnat_argc := argc;
      gnat_argv := argv;
      gnat_envp := envp;

      Initialize (SEH'Address);
      adainit;
      Ada_Main_Program;
      adafinal;
      Finalize;
      return (gnat_exit_status);
   end;

--  BEGIN Object file/option list
   --   C:\Users\arek\pwir\pwir\obj\handlers.o
   --   C:\Users\arek\pwir\pwir\obj\main.o
   --   -LC:\Users\arek\pwir\pwir\obj\
   --   -LC:\Users\arek\pwir\pwir\obj\
   --   -LC:\bin\GtkAda\lib\gtkada\gtkada.static\gtkada\
   --   -LC:/bin/gnat17/lib/gcc/i686-pc-mingw32/6.3.1/adalib/
   --   -static
   --   -shared-libgcc
   --   -shared-libgcc
   --   -shared-libgcc
   --   -lgnat
   --   -Wl,--stack=0x2000000
--  END Object file/option list   

end ada_main;
