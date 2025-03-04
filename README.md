# Clean-OldBackups
Script: Keep only the last full backup and its incremental backups.

## Usage
1. Download the script launcher `Clean-OldBackups.Cmd` and the script `Clean-OldBackups.PS1` to your backup folder.  
2. Modify `Clean-OldBackups.PS1` with the required parameters.
3. Execute `Clean-OldBackups.Cmd`. Default regular window mode. Pauses when finished. The launcher can be adjusted with the parameters:
* `Clean-OldBackups.Cmd Minimized` Minimized window mode. Pauses only on error.
* `Clean-OldBackups.Cmd Hidden` Hidden window mode. Exits when finished. The execution result can be judged by the exit code and the output file.
4. Use the Task Scheduler to create periodic execution task.