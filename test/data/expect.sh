echo Include data file as a here document.

echo Path should be relative to where Aranea is called from.
echo Aranea will be called from our project root.

DUMMY_DATA=$(cat << '__test_data_dummy_data_txt'
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam a magna auctor, posuere velit in, tristique erat. In blandit viverra nibh a imperdiet. Curabitur dictum congue velit, eu tristique nisl semper non. Donec finibus, elit sed scelerisque tincidunt, purus diam blandit lorem, nec mattis odio nibh non nisi. Vestibulum malesuada odio non tortor aliquam finibus. Morbi condimentum ante sit amet lorem laoreet tristique. Nam in risus rhoncus neque tempor lacinia a non tellus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Ut tristique, magna at bibendum vehicula, urna dolor sollicitudin felis, id volutpat leo est congue neque. Praesent tempor orci id tellus vestibulum, id ultricies nisl porttitor. Phasellus ac tellus vitae velit pellentesque pellentesque in blandit ligula. Suspendisse ut semper metus, vitae posuere dolor. Nullam at maximus magna. Aliquam convallis dolor eu nibh rutrum, sit amet rutrum nisi pharetra.

Nam et euismod ante, ac scelerisque tortor. Mauris vulputate porttitor quam vel malesuada. Donec posuere ultrices interdum. Proin porttitor tellus tincidunt arcu efficitur, quis congue purus aliquam. Integer quis magna id nisl aliquet tempor eget ut sapien. Cras mollis mauris diam, eu auctor velit mollis eget. Quisque a magna ante. Ut eu arcu nisl. Ut tincidunt ligula et mattis pretium. Nulla tempus convallis ex eget auctor. Nulla est nisl, ultrices vel porttitor eget, ultricies rhoncus sapien. Nunc sed elit rhoncus, pretium magna ac, congue nulla. Aenean congue elementum imperdiet. Suspendisse vel iaculis purus. Aliquam accumsan ante elit, quis consequat sem vehicula vel. Fusce viverra eget diam id aliquet.

Mauris sagittis felis id est pellentesque congue. In eleifend gravida ipsum, eget luctus diam convallis tincidunt. Morbi eget dolor quis leo ornare pharetra. Nullam nec sagittis felis. Donec mi lorem, dapibus in sem et, euismod dignissim purus. Phasellus malesuada finibus quam eu feugiat. Nulla facilisi. Maecenas dictum quam scelerisque, pulvinar risus vel, mattis est. Nulla laoreet rhoncus quam, ut elementum mauris rutrum vel. Vestibulum faucibus vehicula sapien porta congue. Nam ut mollis mauris, eu feugiat dui. Donec dapibus est risus. Fusce tristique non mauris luctus vehicula. Curabitur condimentum lacus urna, et maximus diam consectetur mattis.

In auctor urna sit amet risus euismod interdum. Phasellus fringilla purus dolor, id eleifend erat tempor ut. Nullam ut augue sit amet magna sagittis sodales. Proin viverra urna ut tellus ullamcorper consectetur. Mauris placerat ex sed nunc tristique, a feugiat augue tristique. Donec odio metus, tempor non magna vestibulum, tempus molestie tellus. Ut porta diam eget massa porta convallis. Etiam sit amet tellus vulputate, mattis sem et, finibus leo. Nunc aliquam lorem erat, et tincidunt nibh dapibus nec. Donec vitae purus id nunc viverra venenatis. Donec nec urna id risus sodales gravida. Vestibulum egestas massa sed enim pellentesque dapibus. Maecenas quis ligula vitae ligula maximus lobortis. Quisque placerat convallis blandit. Morbi quam elit, rhoncus non ligula at, faucibus vulputate quam. Cras ultricies urna magna, vitae semper nisi tincidunt vitae.

Nulla non felis condimentum augue rhoncus euismod. Fusce quis blandit nisl, sit amet convallis erat. Aenean malesuada nulla sed neque molestie ornare. Etiam non turpis eu erat pharetra vulputate. Curabitur elementum interdum pulvinar. Fusce sagittis vehicula nulla, ut pulvinar mi dignissim quis. Ut finibus sit amet orci vitae facilisis. 
__test_data_dummy_data_txt
)

echo Data included: "$DUMMY_DATA"
