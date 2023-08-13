FROM debian
RUN dpkg --add-architecture i386
RUN apt update
RUN DEBIAN_FRONTEND=noninteractive apt install wine qemu-kvm *zenhei* xz-utils dbus-x11 curl firefox-esr git xfce4 xfce4-terminal tightvncserver wget vim python3 gcc -y
RUN wget https://github.com/novnc/noVNC/archive/refs/tags/v1.2.0.tar.gz
RUN tar -xvf v1.2.0.tar.gz
RUN mkdir $HOME/.vnc
RUN echo 'intelfree' | vncpasswd -f > $HOME/.vnc/passwd
RUN echo '/bin/env MOZ_FAKE_NO_SANDBOX=1 dbus-launch xfce4-session' > $HOME/.vnc/xstartup
RUN chmod 600 $HOME/.vnc/passwd
RUN chmod 755 $HOME/.vnc/xstartup
RUN echo 'whoami ' >> /launch.sh
RUN echo 'cd ' >> /launch.sh
RUN echo "su -l -c 'vncserver :2000 -geometry 1360x768' " >> /launch.sh
RUN echo 'cd /noVNC-1.2.0' >> /launch.sh
RUN echo './utils/launch.sh --vnc localhost:7900 --listen 8900 ' >> /launch.sh
RUN chmod 755 /launch.sh
EXPOSE 8900
CMD /launch.sh
