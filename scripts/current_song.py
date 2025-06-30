import subprocess
import click
import json

def get_cmd_output(command):
    return subprocess.check_output(command, shell=True, stderr=subprocess.STDOUT).decode()

def get_song_info():
    status = get_cmd_output("playerctl -s status | tail -n1")
    song_info = get_cmd_output("playerctl metadata --format='{{title}} - {{artist}}'")
    if status == "Paused":
        return {"status": status.upper(), "song_info": song_info}
    if status == "Playing":
        return {"status": status.upper(), "song_info": song_info}
    if status == "Stopped":
        return {"status": status.upper()}
    else:
        return {"status": "OFFLINE"}

@click.command()
def current_song():
    song_info = get_song_info()
    click.echo(json.dumps(song_info))

