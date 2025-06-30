import click
import time
import subprocess

def get_cmd_output(command):
    return subprocess.check_output(command, shell=True).decode().replace('\n', '')

@click.command()
@click.option('--scroll-interval', default=1)
@click.option('--exec', prompt='Command to get output from')
@click.option('--exec-interval', default=3)
@click.option('--max-length', default=30)
@click.option('--separator', default=' ')
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
