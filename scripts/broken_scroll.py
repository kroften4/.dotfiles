import click
import time
import subprocess

def get_cmd_output(command):
    return subprocess.check_output(command, shell=True).decode().replace('\n', '')

def scroll_text(scroll_interval, current_song_fn, exec_interval, exec_callback, max_length, separator):
    exec_interval_count = 0
    cmd_output = current_song_fn()
    message = (cmd_output + separator) * 2
    if len(cmd_output) <= max_length:
        output = cmd_output
    else:
        output = message[:max_length]
    yield exec_callback(output)
    scroll_index = 1
    while (True):
        exec_interval_count += 1
        time.sleep(scroll_interval)
        if exec_interval_count >= exec_interval:
            cmd_output = current_song_fn()
            new_message = (current_song_fn() + separator) * 2
            exec_interval_count = 0
            if new_message != message:
                scroll_index = 0
                message = new_message
                output = message[:max_length]
        yield exec_callback(output)
        scroll_index += 1
        scroll_index = scroll_index % (len(message) // 2)
        if len(cmd_output) <= max_length:
            output = cmd_output
        else:
            output = message[scroll_index : scroll_index + max_length]

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

def format_song_info(song_info, status):
    if status == "PLAYING":
        return f" {song_info["song_info"]}"
    if status == "PAUSED":
        return f" {song_info["song_info"]}"
    if status == "STOPPED":
        return f" Nothing is playing"
    if status == "OFFLINE":
        return " Player is offline"

@click.command()
@click.option('--scroll-interval', default=1)
@click.option('--exec-interval', default=3)
@click.option('--max-length', default=30)
@click.option('--separator', default=' ')
@click.option('--paused-prefix', default=' ')
@click.option('--playing-prefix', default=' ')
def scroll_song(scroll_interval, exec_interval, max_length, separator,
                paused_prefix, playing_prefix):

    for scroll in scroll_text(scroll_interval, , , exec_interval, max_length, separator):
        click.echo(

def scroll(scroll_interval, exec, exec_interval, max_length, separator):
    exec_interval_count = 0
    cmd_output = get_cmd_output(exec)
    message = (cmd_output + separator) * 2
    if len(cmd_output) <= max_length:
        output = cmd_output
    else:
        output = message[:max_length]
    click.echo(output)
    scroll_index = 1
    while (True):
        exec_interval_count += 1
        time.sleep(scroll_interval)
        if exec_interval_count >= exec_interval:
            cmd_output = get_cmd_output(exec)
            new_message = (get_cmd_output(exec) + separator) * 2
            exec_interval_count = 0
            if new_message != message:
                scroll_index = 0
                message = new_message
                output = message[:max_length]
        click.echo(output)
        scroll_index += 1
        scroll_index = scroll_index % (len(message) // 2)
        if len(cmd_output) <= max_length:
            output = cmd_output
        else:
            output = message[scroll_index : scroll_index + max_length]

if __name__ == "__main__":
    scroll()
