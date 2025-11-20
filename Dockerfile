# License: NEURODOCK SOFTWARE LICENSE AGREEMENT
# For full terms, see the LICENSE file included in this repository.

# Usar una imagen base de Ubuntu
FROM ubuntu:20.04

# Instalar dependencias críticas
RUN apt-get update && apt-get install -y \
wget \
unzip \
libxt6 \
libxmu6 \
libglu1-mesa \
libxrandr2 \
libxcursor1 \
libxi6 \
libglib2.0-0 \
libsm6 \
xvfb \
openjdk-11-jre-headless \
libxaw7 \
libxrender1 \
libxtst6 \
libxfixes3 \
libgtk2.0-0 \
libxext6 \
libxinerama1 \
libgl1-mesa-glx \
x11-apps && \
rm -rf /var/lib/apt/lists/*

# Descargar e instalar Matlab Runtime
WORKDIR /tmp
RUN wget -O matlab_runtime.zip "https://ssd.mathworks.com/supportfiles/downloads/R2023a/Release/8/deployment_files/installer/complete/glnxa64/MATLAB_Runtime_R2023a_Update_8_glnxa64.zip" && \
unzip matlab_runtime.zip && \
./install -mode silent -agreeToLicense yes

# Configurar variables de entorno con la ruta correcta de MATLAB Runtime
ENV MATLABROOT=/opt/matlab_runtime/R2023a
ENV LD_LIBRARY_PATH=${MATLABROOT}/runtime/glnxa64:${MATLABROOT}/bin/glnxa64:${MATLABROOT}/sys/os/glnxa64
ENV XAPPLRESDIR=${MATLABROOT}/X11/app-defaults

# Copiar Brainstorm
COPY brainstorm3 /opt/brainstorm

RUN chmod +x /opt/brainstorm/bin/R2023a/brainstorm3.command
# Copiar el script desde el host al contenedor
#COPY entrypoint.sh /usr/local/bin/entrypoint.sh
#RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/opt/brainstorm/bin/R2023a/brainstorm3.command"]





