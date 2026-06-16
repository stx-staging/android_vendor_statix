# Copyright (C) 2026 Project Cerium
#

# Recovery UI
TARGET_RECOVERY_UI_LIB := librecovery_ui_statix

# The Make-to-Soong bridge
SOONG_CONFIG_NAMESPACES += recovery
SOONG_CONFIG_recovery += target_recovery_ui_lib
SOONG_CONFIG_recovery_target_recovery_ui_lib := librecovery_ui_statix
