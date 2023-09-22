FROM fnndsc/ubuntu-python3

RUN apt-get update

RUN apt-get install unzip -y

RUN python3 -m pip install --upgrade pip

RUN python3 -m pip install imagededup

WORKDIR /

COPY ./setup.sh ./setup.sh

RUN chmod +x ./setup.sh

COPY ./dedup.py ./dedup.py

RUN chmod +x ./dedup.py 

CMD [ "/output/mland.zip" ]

ENTRYPOINT [ "/setup.sh" ]