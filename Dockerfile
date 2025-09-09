FROM scratch
COPY aurora /aurora
ENTRYPOINT ["/aurora"]