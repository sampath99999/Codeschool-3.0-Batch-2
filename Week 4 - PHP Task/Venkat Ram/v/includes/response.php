<?php
function response($status=false,$message="",$data=null){

echo json_encode(['status'=> $status,'message'=>$message,'data'=>$data]);
exit();
}
