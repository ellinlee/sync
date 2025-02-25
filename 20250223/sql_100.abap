PROCESS BEFORE OUTPUT.
  MODULE status_0100.
  MODULE clear_okcode.


PROCESS AFTER INPUT.
  MODULE exit AT EXIT-COMMAND.
  FIELD scustom-name MODULE mark_changed ON REQUEST.
  MODULE user_command_0100.