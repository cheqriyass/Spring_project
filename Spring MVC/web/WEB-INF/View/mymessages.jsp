<%@ page import="Model.Entities.Message" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Entities.Contacts" %>
<%@ taglib prefix="c" uri="http://www.springframework.org/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Home</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"
          integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css" rel="stylesheet"
          integrity="sha384-T8Gy5hrqNKT+hzMclPo118YTQO6cYprQmhrYwIiQ/3axmI1hQomh7Ud2hPOy8SP1" crossorigin="anonymous">
    <link href="<c:url value="/resources/chat.css"/>" rel="stylesheet" type="text/css">


    <style type="text/css">
        /*custom font*/
        @import url(http://fonts.googleapis.com/css?family=Montserrat);

        /*basic reset*/
        * {
            margin: 0;
            padding: 0;
        }

        body {
            font-family: montserrat, arial, verdana;

        }

        .contactname {
            font-size: 16px;
            padding-left: 10px;
        }

        .contact {
            border-bottom: solid 3px #ffffff;
            height: 80px;
            padding-top: 8px;
            padding-left: 20px;
            background-color: #edeff2;
        }

        .contact:hover {
            background-color: #cccccc;
        }

        a {
            text-decoration: none;
        }
    </style>
</head>


<body>

<%@ include file="navbar.jsp" %>

<%
    List<Message> messages = (List<Message>) request.getSession().getAttribute("messages");
    List<Contacts> contacts = (List<Contacts>) request.getSession().getAttribute("contacts");
    int id = (Integer) request.getSession().getAttribute("id");


%>


<br/>
<br/>


<div class="chat_window">
    <div class="top_menu">
        <div class="title">Chat</div>
    </div>
    <ul class="messages"></ul>
    <div class="bottom_wrapper clearfix">
        <div class="message_input_wrapper"><input class="message_input" placeholder="Type your message here..."/></div>
        <div class="send_message">
            <div class="icon"></div>
            <div class="text">Send</div>
        </div>
    </div>
</div>

<div class="message_template">
    <li class="message">
        <div class="avatar"></div>
        <div class="text_wrapper">
            <div class="text"></div>
        </div>
    </li>
</div>


<div class="chat_window2">
    <div class="top_menu">
        <div class="title">Contacts</div>
    </div>

    <%
        for (Contacts c : contacts) {

    %>
    <a href="/cotransport/mymessage?id=<%=id%>&otherid=<%=c.getId()%>" style="text-decoration: none">
        <div class="contact">
            <span><img width="70" height="70" src="<c:url value="/resources/contact.png"/>"></span>
            <span class="contactname"><%=c.getNom()%></span>
        </div>
    </a>

    <%
        }
    %>

</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

<script type="application/javascript">
    (function () {
        var Message;
        Message = function (arg) {
            this.text = arg.text, this.message_side = arg.message_side;
            this.draw = function (_this) {
                return function () {
                    var $message;
                    $message = $($('.message_template').clone().html());
                    $message.addClass(_this.message_side).find('.text').html(_this.text);
                    $('.messages').append($message);
                    return setTimeout(function () {
                        return $message.addClass('appeared');
                    }, 0);
                };
            }(this);
            return this;
        };


        $(function () {
            var getMessageText, message_side, sendMessage;
            //message_side = 'right';
            getMessageText = function () {
                var $message_input;
                $message_input = $('.message_input');
                return $message_input.val();
            };
            sendMessage = function (text, side) {
                var $messages, message;
                if (text.trim() === '') {
                    return;
                }
                $('.message_input').val('');
                $messages = $('.messages');
                message_side = side;
                message = new Message({
                    text: text,
                    message_side: message_side
                });
                message.draw();
                return $messages.animate({scrollTop: $messages.prop('scrollHeight')}, 300);
            };
            $('.send_message').click(function (e) {
                return sendMessage(getMessageText(), 'right');
            });
            $('.message_input').keyup(function (e) {
                if (e.which === 13) {
                    return sendMessage(getMessageText(), 'right');
                }
            });


            <%
                String dir = null;
                List<Message> messageList = (List<Message>)request.getSession().getAttribute("messages");
                for (Message m : messageList) {
                    if (m.getRecepteur().getId()==id)
                        dir = "left";
                    else
                        dir = "right";

            %>

            sendMessage('<%=m.getMessage()%>', '<%=dir%>');
            <%

                }
            %>


        });
    }.call(this));
</script>
</body>
</html>


