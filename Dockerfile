FROM python:2.7

ENV PYTHONUNBUFFERED=1 \
    HOME_DIR=/home/jasmin-api \
    USER_NAME=jasmin-api \
    USER_GROUP=www-data

RUN apt-get update && apt-get install -y --no-install-recommends telnet

COPY requirements.txt /
RUN pip install --no-cache-dir -r /requirements.txt && \
    rm /requirements.txt && \
    useradd -u 1000 -d ${HOME_DIR} -G ${USER_GROUP} ${USER_NAME} && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/log/* ~/.cache

COPY ./jasmin_api ${HOME_DIR}
RUN chown -R ${USER_NAME}:${USER_GROUP} ${HOME_DIR}

WORKDIR ${HOME_DIR}
USER ${USER_NAME}

EXPOSE 8001
CMD ["python", "manage.py", "runserver", "0.0.0.0:8001"]
