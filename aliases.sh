tfr ()
{
    TF_AUTO_APPROVE='';
    TF_FIXTURES='';
    TF_FIXTURES=$(for i in $(ls fixtures* 2>/dev/null) ; do echo -n "-var-file=${i} " ; done);
    [[ ${1} == "-y" ]] && TF_AUTO_APPROVE='-auto-approve' && shift;
    terraform apply ${TF_AUTO_APPROVE} ${TF_FIXTURES} ${@};
}

tfd ()
{
    TF_AUTO_APPROVE='';
    TF_FIXTURES='';
    TF_FIXTURES=$(for i in $(ls fixtures* 2>/dev/null) ; do echo -n "-var-file=${i} " ; done);
    [[ ${1} == "-y" ]] && TF_AUTO_APPROVE='-auto-approve';
    terraform destroy ${TF_AUTO_APPROVE} ${TF_FIXTURES} ${@};
    unset TF_AUTO_APPROVE
}

tfi ()
{
    TF_FIXTURES='';
    TF_FIXTURES=$(for i in $(ls fixtures* 2>/dev/null) ; do echo -n "-var-file=${i} " ; done);
    terraform import ${TF_FIXTURES} ${@}
}
