**// new(lib = nil, flags = Fiddle::RTLD_LAZY | Fiddle::RTLD_GLOBAL)
**// Create a new handler that opens library named lib with flags. If no library is specified, RTLD_DEFAULT is used

               static VALUE
rb_fiddle_handle_initialize(int argc, VALUE argv[], VALUE self)
{
    void *ptr;
    struct dl_handle *fiddle_handle;
    VALUE lib, flag;
    char  *clib;
    int   cflag;
    const char *err;

    switch( rb_scan_args(argc, argv, "02", &lib, &flag) ){
      case 0:
        clib = NULL;
        cflag = RTLD_LAZY | RTLD_GLOBAL;
        break;
      case 1:
        clib = NIL_P(lib) ? NULL : SafeStringValueCStr(lib);
        cflag = RTLD_LAZY | RTLD_GLOBAL;
        break;
      case 2:
        clib = NIL_P(lib) ? NULL : SafeStringValueCStr(lib);
        cflag = NUM2INT(flag);
        break;
      default:
        rb_bug("rb_fiddle_handle_new");
    }

    rb_secure(2);

#if defined(_WIN32)
    if( !clib ){
        HANDLE rb_libruby_handle(void);
        ptr = rb_libruby_handle();
    }
    else if( STRCASECMP(clib, "libc") == 0
# ifdef RUBY_COREDLL
             || STRCASECMP(clib, RUBY_COREDLL) == 0
             || STRCASECMP(clib, RUBY_COREDLL".dll") == 0
# endif
        ){
# ifdef _WIN32_WCE
        ptr = dlopen("coredll.dll", cflag);
# else
        ptr = w32_coredll();
# endif
    }
    else
#endif
        ptr = dlopen(clib, cflag);
#if defined(HAVE_DLERROR)
    if( !ptr && (err = dlerror()) ){
        rb_raise(rb_eFiddleError, "%s", err);
    }
#else
    if( !ptr ){
        err = dlerror();
        rb_raise(rb_eFiddleError, "%s", err);
    }
#endif
    TypedData_Get_Struct(self, struct dl_handle, &fiddle_handle_data_type, fiddle_handle);
    if( fiddle_handle->ptr && fiddle_handle->open && fiddle_handle->enable_close ){
        dlclose(fiddle_handle->ptr);
    }
    fiddle_handle->ptr = ptr;
    fiddle_handle->open = 1;
    fiddle_handle->enable_close = 0;

    if( rb_block_given_p() ){
        rb_ensure(rb_yield, self, rb_fiddle_handle_close, self);
    }

    return Qnil;
}
