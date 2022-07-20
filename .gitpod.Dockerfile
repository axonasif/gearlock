FROM gitpod/workspace-full

USER root

ENV MICROVM_KERNEL=linux-5.12.10
ENV MISC_DIR=$HOME/misc

# Install build dependencies
RUN apt-get update \
	&& apt-get install -yq flex qemu-system qemu cpio rsync archivemount

# Download kernel source
RUN cd /tmp \
	&& wget https://cdn.kernel.org/pub/linux/kernel/v5.x/${MICROVM_KERNEL}.tar.xz \
	&& tar -xf linux-5.12.10.tar.xz

# Compile kernel source
COPY defconfig /tmp/${MICROVM_KERNEL}
RUN cd /tmp/${MICROVM_KERNEL} \
	&& make olddefconfig \
	&& make -j8

# Copy the kernel
USER gitpod
RUN mkdir -p "${MISC_DIR}" \
	&& cp "/tmp/${MICROVM_KERNEL}/arch/x86/boot/bzImage" "${MISC_DIR}/microkernel"

# Install bashbox
RUN curl --proto '=https' --tlsv1.2 -sSfL "https://git.io/Jc9bH" | bash -s selfinstall